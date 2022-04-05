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
