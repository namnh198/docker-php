# Docker PHP

## Docker HUB

- Nginx
- Mysql 8.0
- PHP-FPM 7.4
- Elasticsearch

# Requirement

- Docker
- Docker-compose

## Usage

```
git clone https://github.com/namnh198/docker-php.git
cd docker-php
cp .env.example .env #change config here
docker-compose up -d
```

## Use command

ADD PATH for .bashrc or .zshrc

```
if [ -d "$HOME/docker-php/bin" ] ; then
    PATH="$HOME/docker-php/bin:$PATH"
fi
```

## Command

- Exec PHP Container: `exec`
- Check PHP Version: `php -v`. PHP only run & execute `PHP file` in `www`
- MySQL Exec: `mysql -uroot -proot`
- Xdebug Status: `xdebug status`
- Xdebug Enable: `xdebug enable`
- Xdebug Disable: `xdebug disable`
- Xdebug Toggle: `xdebug toggle`

## SSL


Create Certificate

```
cd YOUR_PROJECT/config/mkcert
mkcert -cert-file YOUR_DOMAIN.crt -key-file YOUR_DOMAIN.key YOUR_DOMAIN
```

Nginx Config

```
listen 443 ssl;

ssl_certificate /etc/nginx/mkcert/YOUR_DOMAIN.crt;
ssl_certificate_key /etc/nginx/mkcert/YOUR_DOMAIN.key;
ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
ssl_ciphers HIGH:!aNULL:!MD5;
```
