Nginx-PHP7FPM
=====

Introduction
----
This is the simple Dockerfile to build a image that with Nginx and PHP7-FPM daemon support.

Usage
----
1. Download or Clone the Dockerfile into local;
2. Execute the belows command in terminals:


        cd nginx-php7fpm
        docker build --build-arg UID=$UID --build-arg GID=`id -g` --build-arg USERNAME=`whoami` -t nginx-php7fpm .

Build Arguments
----
* UID: The daemon execution user id; default is 1000
* GID: The daemon execution user's group id; default is 1000
* USERNAME: The daemon execution user name; default is thisuser

Homepage
----
https://github.com/kensonman/nginx-php7fpm
