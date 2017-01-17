Nginx-PHP7FPM
=====

Homepage
----
https://github.com/kensonman/nginx-php7fpm

Introduction
----
This is the simple Dockerfile to build a image that with Nginx and PHP7-FPM daemon support.


The Nginx is base on the [offical docker image](https://hub.docker.com/_/nginx).


The PHP was installed by [Dotdeb](https://www.dotdeb.org).

Usage
----
1. Download or Clone the Dockerfile into local;
2. Execute the belows command in terminals:


        cd nginx-php7fpm
        docker build --build-arg UID=$UID --build-arg GID=`id -g` --build-arg USERNAME=`whoami` -t nginx-php7fpm .

Extra PHP Module
----
The container installed the belows modules:
* php7.0-fpm 
* php7.0-gd 
* php7.0-curl 
* php7.0-mysql 
* php7.0-imap 
* php-pear 

If you need to install extra php module, simply create the docker-file as belows:


        FROM kensonman/nginx-php7fpm:latest
        RUN apt update \
        && apt install -y <php-extra-modules>

Then execute the build command like this:


	cd <docker-file directory>
	docker build -t newTag .

Build Arguments
----
* UID: The daemon execution user id; default is 1000;
* GID: The daemon execution user's group id; default is 1000;
* USERNAME: The daemon execution user name; default is thisuser;
* PASSWD: The FTP password of the daemon execution user;
