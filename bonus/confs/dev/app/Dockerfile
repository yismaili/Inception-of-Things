FROM debian:buster

RUN apt update && apt  install -y nginx 

COPY ./tools/wibsete/ /var/www/html/

COPY ./conf/default.conf /etc/nginx/sites-enabled/default

CMD ["nginx", "-g", "daemon off;"]
