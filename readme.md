Spinning up local environment

* clone down this docker repo

* copy over the following files into ```eldorado/conf/``` and ```challanges/conf/ directories (files not included)
- app_local.ini   <-- required for eldorado app to run
- github.priv   <--- your locally stored (or a new one you create for this) github id_rsa private key for connecting to the eldorado repo.
- github.pub  <-- same as private. but your public.

* run cmd: ```docker-compose -f docker-compose.local.yml -p eldorado up```

* verify successful launch by opening a browser and going to: 127.0.0.1:8080. You should see ```{"status":"Ok","message":"Welcome!"}```

* verify container is up and running. and attach to container in IDE of choice.

