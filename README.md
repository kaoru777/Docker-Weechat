# Information
This Docker image will install the latest weechat version from the weechat repository.

# Configuration
docker-compose.yml example  
```
version: '3'
services:
  weechat:
    container_name: weechat
    image: kaoru777/weechat
    restart: unless-stopped
    stdin_open: true
    tty: true
    volumes:
      - weechat:/weechat
    environment:
      - PUID=1000
      - PGID=1000
```

to attach use `docker attach weechat`
