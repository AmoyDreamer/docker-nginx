# docker-nginx
A docker image of [Nginx](https://nginx.org).

## Download
```
docker pull amoydreamer/nginx:1.21.0
```

## Usage

### Ready
- For easy maintenance of standalone site configuration, you can edit config file in the directory **/path/to/nginx/conf.d**, like this file named **test.demo.com.conf**
```
server {
    listen 80;
    listen 443 ssl;
    server_name test.demo.com;
    ssl_certificate      /path/to/https_certs/test.demo.com.crt;
    ssl_certificate_key  /path/to/https_certs/test.demo.com.key;
    root /path/to/projects/test.demo.com;
    error_log /path/to/logs/test.demo.com.error.log;
    access_log  /path/to/logs/test.demo.com.access.log;
    location / {
        index index.html;
    }
}
```
- You must import the config directory **conf.d** in **nginx.conf** file, like this:
```
...
http {
    include conf.d/*.conf;
    ...
}
...
```
- The directory **/path/to/nginx/conf.d** and the file **/path/to/nginx/nginx.conf** must be mounted data volumes when creating containers.

### Create a runtime container with current image
```
docker run --name nginx-1.21.0 -d \
-p 80:80 \
-p 443:443 \
--restart=always \
-v /path/to/nginx/nginx.conf:/usr/local/nginx/nginx.conf \
-v /path/to/nginx/conf.d:/usr/local/nginx/conf.d \
-v /path/to/https_certs:/etc/ssl/https_certs \
-v /path/to/projects:/data/projects \
-v /path/to/logs:/data/logs \
amoydreamer/nginx:1.21.0
```

## License
docker-nginx is [MIT licensed](https://github.com/AmoyDreamer/docker-nginx/blob/master/LICENSE).
