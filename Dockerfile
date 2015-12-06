FROM nginx:1.9

COPY /config/nginx/site.conf /etc/nginx/conf.d/default.conf
