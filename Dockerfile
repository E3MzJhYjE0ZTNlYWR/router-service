FROM nginx:1.11.4

ADD package.zip.enc /home

CMD cd /home && \
	apt-get update -y && \
	apt-get install unzip -y && \
	apt-get clean && \
	openssl enc -d -aes-256-cbc -in package.zip.enc -out package.zip -pass pass:$UNLOCK_KEY && \
	unzip package.zip && \
	mkdir -p /etc/nginx && \
	mkdir -p /var/tmp/nginx && \
	mv package/* /etc/nginx && \
	
	nginx -g 'daemon off;' -c /etc/nginx/nginx.conf