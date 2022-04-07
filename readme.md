Spinning up local environment

* clone down this docker repo

* copy over the following files into ```devious/conf/``` directory (files not included)
- app_local.ini   <-- as of now, this can just be a blank file.
- github.priv   <--- your locally stored (or a new one you create for this) github id_rsa private key for connecting to the eldorado repo.
- github.pub  <-- same as private. but your public.

* cd into ```devious_box/docker/``` directory

* run cmd: ```docker-compose -f docker-compose.local.yml -p eldorado up```

* verify successful launch by opening a browser and going to: 127.0.0.1:8000. You should see ```{"message":"Hello World"}```

* verify container is up and running. and attach to container in IDE of choice.

