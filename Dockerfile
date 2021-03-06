FROM aegypius/confd

# Installing required packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends nginx curl

# Clean packages 
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# configuring default nginx
RUN rm /etc/nginx/sites-enabled/default
ADD add/nginx.conf /etc/nginx/nginx.conf

# adding confd_watch
ADD add/confd_watch /usr/local/bin/confd_watch
RUN chmod +rx /usr/local/bin/confd_watch

ENV ETCD_PORT "4001"
ENV HOST_IP "127.0.0.1"

# making confd directory
RUN mkdir /etc/confd
VOLUME /etc/confd/

CMD ["/usr/local/bin/confd_watch"]
