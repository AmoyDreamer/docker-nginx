# basic image
FROM centos:7.9.2009

# update software package, install dependencies, set localtime
RUN yum install -y deltarpm \
    && yum -y update \
    && yum install -y wget rsync perl pcre-devel gcc gcc-c++ make zlib-devel \
    && cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# install openssl v1.1.1
RUN wget https://www.openssl.org/source/openssl-1.1.1k.tar.gz -P /root \
    && tar -zxvf /root/openssl-1.1.1k.tar.gz -C /root \
    && cd /root/openssl-1.1.1k \
    && ./config --prefix=/usr/local/openssl shared zlib-dynamic \
    && make && make install

# install nginx v1.21.0
RUN wget https://nginx.org/download/nginx-1.21.0.tar.gz -P /root \
    && tar -zxvf /root/nginx-1.21.0.tar.gz -C /root \
    && cd /root/nginx-1.21.0 && ./configure \
    --sbin-path=/usr/local/nginx/nginx \
    --conf-path=/usr/local/nginx/nginx.conf \
    --pid-path=/usr/local/nginx/nginx.pid \
    --user=root \
    --group=root \
    --with-http_realip_module \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-openssl=../openssl-1.1.1k \
    && make && make install

# remove all package
RUN rm -rf /root/openssl-1.1.1k.tar.gz \
    && rm -rf /root/nginx-1.21.0.tar.gz

EXPOSE 80 443

CMD ["/usr/local/nginx/nginx", "-g", "daemon off;"]
