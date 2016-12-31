FROM nginx:latest
MAINTAINER Kenson Man <kenson@kenson.idv.hk>
ENV UID=1000
ENV GID=1000
ENV USERNAME=thisuser

RUN \
   echo ">>> Installating the system dependencies..."   \
&& apt update  \
&& apt install -y vim ufw software-properties-common \
&& echo ">>> Installing the php extension..." \
&& LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
&& apt update  \
&& apt install -y php7.0-fpm php7.0-gd php7.0-curl php7.0-mysql php7.0-imap php-pear\
&& echo ">>> Creating the user<${USERNAME}::${UID}> and group<${GID}>..."  \
&& groupadd -g ${GID} ${USERNAME} \
&& useradd -u ${UID} -g ${GID} -M -d /home/${USERNAME} ${USERNAME} \
&& echo ">>> Generating the startup scripts..." \
&& echo "#!/bin/bash" > /startup \
&& echo "/usr/bin/nginx -g \"daemon off;\" &" >> /startup \
&& echo "/usr/bin/php-fpm" >> /startup \
&& chown ${USERNAME}:${USERNAME} /startup \
&& chmod +x /startup \

USER ${USERNAME}
WORKDIR /usr/share/nginx/html
CMD "/startup"




