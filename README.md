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

ADD Alias for .bashrc or .zshrc

```
alias exec="$HOME/docker-php/bin/exec"
alias php="$HOME/docker-php/bin/php"
alias mysql="$HOME/docker-php/bin/mysql"
alias xdebug="$HOME/docker-php/bin/xdebug"
```

## Command
- Exec PHP Container: `exec`
- Check PHP Version: `php -v`
- MySQL Exec: `mysql -uroot -proot`
- Xdebug Status: `xdebug status`
- Xdebug Enable: `xdebug enable`
- Xdebug Disable: `xdebug disable`
- Xdebug Toggle: `xdebug toggle`
