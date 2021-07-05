# docker-nginx
A docker image of [Nginx](https://nginx.org).

## Download
```
docker pull amoydreamer/nginx:1.21.0
```

## Usage

### Create a runtime container with current image
```
docker run --name nginx-1.21.0 -d \
-p 80:80 \
-p 443:443 \
--restart=always \
-v /path/to/nginx/nginx.conf:/usr/local/nginx/nginx.conf \
-v /path/to/nginx/conf.d:/usr/local/nginx/conf.d \
-v /path/to/https_certs:/etc/ssl/https_certs \
amoydreamer/nginx:1.21.0
```

## License
docker-nginx is [MIT licensed](https://github.com/AmoyDreamer/docker-nginx/blob/master/LICENSE).
