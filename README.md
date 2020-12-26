# Apache x ModSecurity v3 x PHP7

[![License](https://img.shields.io/github/license/nbeguier/apache-modsecurity3-php7?color=blue)](https://github.com/nbeguier/apache-modsecurity3-php7/blob/master/LICENSE) [![docker-build](https://img.shields.io/docker/cloud/automated/nbeguier/apache-modsecurity3-php7)](https://hub.docker.com/r/nbeguier/apache-modsecurity3-php7)

ModSecurity bypass training with OWASP rules (Apache2 x ModSecurity v3 x PHP 7)

## Usage

```
$ docker run -d --rm -v ${PWD}:/var/www/html/current -p 8081:80 --name modsec_lab nbeguier/apache-modsecurity3-php7

# Default HTTP page
$ curl http://localhost:8081/index.html

# Default phpinfo
$ curl http://localhost:8081/hidden.php

# Shared directory
$ curl http://localhost:8081/current/
```

## Labs example

### SEC642 mod_security
```
# In your current directory
$ git clone https://github.com/SEC642/modsec

# firefox http://localhost:8081/current/modsec/
# Play with XSS Input and try to bypass mod_security
$ curl -s 'http://localhost:8081/current/modsec/index.php' --data 'xss=hello' -w "%{http_code}\n" -o /dev/null
200
$ curl -s 'http://localhost:8081/current/modsec/index.php' --data 'xss=<script>alert(XSS)</script>' -w "%{http_code}\n" -o /dev/null
403
```

# License
Licensed under the [Apache License](https://github.com/nbeguier/apache-modsecurity3-php7/blob/master/LICENSE), Version 2.0 (the "License").

# Copyright
Copyright 2020-2021 Nicolas BEGUIER; ([nbeguier](https://beguier.eu/nicolas/) - nicolas_beguier[at]hotmail[dot]com)


