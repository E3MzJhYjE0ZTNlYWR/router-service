FROM nginx:1.11.4

ADD package.zip.enc /home

CMD cd /home && \
	openssl enc -d -aes-256-cbc -in package.zip.enc -out package.zip -pass pass:$UNLOCK_KEY && \
	unzip package.zip && \
	mkdir -p /etc/nginx && \
	mv package/* /etc/nginx && \
	
	nginx -g 'daemon off;' -c /etc/nginx/nginx.conf