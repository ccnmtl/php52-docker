== Background ==
We started running mediawikis in '04-'05. After a few dozen, we couldn't manage farming these anymore and started working with wikispaces

There aren't too many things our clients ever wanted to do in mediawiki that they couldn't do (better) in WS. Nonetheless, a few stragglers remain.

== Ancient MW's and PHP 5.2 ==
These mediawikis won't run under php5.3, and upgrading them isn't straightforward, since we customized the themes, and they run under the cocockamamie farming scheme jsb cooked up in '05. Made sense back then.  All the wikis run off the same code base, with thin shims to bootstrap their environment. But, the standard MW maintence tools don't quite work with this scheme. 

== Enter Docker ==
Spinning up a version of php 5.2 isn't trivial. All the major distros stoped packaging it years ago, and the OSes that support it are also deprecated.

This container comes close, though it's not exactly ideal.

https://registry.hub.docker.com/u/former03/dev03-apache-php-5.2-squeeze/dockerfile/

It runs php as a cgi, instead of mod_php. Also, it ships w/ mysql, which I don't really want.  But, I was able to get our wikis running (hooray).

== Some adjustments ==
=== httpd conf ===
* You must enable +ExecCGI in apache Options, or you will be plagued with permission errors (which have nothing to do with bootstrap volumes)
* We also must get rid of pretty urls... so, 
** the rewite rules in apache need to go. 
** Indexes needs to be added to Options

=== wiki conf ===
* In each of our InstanceSettings.php files, there is a conditional that sets $wgArticlePath.  It must be set to 	

$wgArticlePath      = "$wgScript?title=$1";

NOT $wgScript/$1

fcgi won't work with pretty urls.

* updating database settings.... still futzing with stuff so this container doesn't take over DOCKER MYSQL env variables with localhost, and lets me point at linked container, but we really need a mysql server on linode anyway, so i'm not too stressed about this.


That's mostly it. Careful with the boot2docker double proxy. I had to expose the same port in my container, not change ports, so the urls all lined up:

e.g., 

To run:

First, make sure you have php running:

docker run -it --rm -p 8880:8880 -v /Users/jonah/projects/php52-docker/www-ccnmtl/:/var/www/ccnmtl/ --link mysql:mysql php52

