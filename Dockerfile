FROM nginx:latest
MAINTAINER Kenson Man <kenson@kenson.idv.hk>
ENV UID=1000
ENV GID=1000
ENV USERNAME=thisuser

RUN \
   echo ">>> Installating the system dependencies..."   \
&& apt update  \
&& apt install -y vim ufw wget mysql-client \
&& echo "<?php phpinfo(); ?>" >> /usr/share/nginx/html/index.php \
&& echo "<!DOCTYPE html><html><head><meta http-equiv=\"Refresh\" content=\"0; URL=index.php\"/></head></html>" > /usr/share/nginx/html/index.html \
&& sed -i 's/^user\s\+nginx;$/user nginx www-data;/' /etc/nginx/nginx.conf \
&& echo ">>> Adding dotdeb to software repository..." \
&& echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list \
&& wget -O - https://www.dotdeb.org/dotdeb.gpg | apt-key add - \
&& apt update \
&& echo ">>> Installing the php extension..." \
&& apt install -y php7.0-fpm php7.0-gd php7.0-curl php7.0-mysql php7.0-imap php-pear \
&& echo ">>> Configuring nginx and php..." \
&& sed -i '11atry_files $uri $uri/ /index.php;' /etc/nginx/conf.d/default.conf \
&& sed -i '04aroot /usr/share/nginx/html;' /etc/nginx/conf.d/default.conf \
&& sed -i '44a}' /etc/nginx/conf.d/default.conf \
&& sed -i '44a        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;' /etc/nginx/conf.d/default.conf \
&& sed -i '44a        include fastcgi_params;' /etc/nginx/conf.d/default.conf \
&& sed -i '44a        fastcgi_split_path_info ^(.+\.php)(.*)$;' /etc/nginx/conf.d/default.conf \
&& sed -i '44a        fastcgi_index index.php;' /etc/nginx/conf.d/default.conf \
&& sed -i '44a        fastcgi_pass unix:/run/php/php7.0-fpm.sock;' /etc/nginx/conf.d/default.conf \
&& sed -i '44alocation ~* \.php$ {' /etc/nginx/conf.d/default.conf \
&& echo ">>> Creating the user<${USERNAME}::${UID}> and group<${GID}>..."  \
&& groupadd -g ${GID} ${USERNAME} \
&& useradd -u ${UID} -g ${GID} -M -d /home/${USERNAME} ${USERNAME} \
&& adduser ${USERNAME} www-data \
&& setcap 'cap_net_bind_service=+ep' /usr/sbin/nginx \
&& echo ">>> Generating the startup scripts..." \
&& echo "#!/bin/bash" > /startup \
&& echo "echo \"Container Homepage: https://github.com/kensonman/nginx-php7fpm\"" >> /startup \
&& echo "/usr/sbin/nginx -g \"daemon off;\" &" >> /startup \
&& echo "/usr/sbin/php-fpm7.0 -F" >> /startup \
&& chown ${USERNAME}:${USERNAME} /startup \
&& chmod +x /startup \
&& echo ">>> Finishing..."

#USER ${USERNAME}
WORKDIR /usr/share/nginx/html
CMD "/startup"
