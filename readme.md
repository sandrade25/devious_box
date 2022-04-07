Spinning up local environment

* clone down this docker repo

* copy over the following files into devious/conf/ directory (files not included)
- app_local.ini
- circus_local.ini
- github.priv
- github.pub
- mime.types
- nginx.conf

* cd into devious_box/ main directory

* ```docker-compose -f docker-compose.local.yml -p eldorado up```
