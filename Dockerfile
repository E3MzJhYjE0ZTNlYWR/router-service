FROM beh01der/docker-openresty

ADD package.zip.enc /home

CMD cd /home && \
	openssl enc -d -aes-256-cbc -in package.zip.enc -out package.zip -pass pass:$UNLOCK_KEY && \
	unzip package.zip && \
	mkdir -p /etc/nginx && \
	mv package/* /etc/nginx && \
	
	/etc/init.d/dnsmasq start && \
	nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
