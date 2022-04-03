if [[ $1 == "local" ]]
then
    cp /srv/circus_local.ini /srv/circus.ini
    rm /srv/circus_local.ini

    git fetch --all

    wget https://github.com/ufoscout/docker-compose-wait/releases/download/2.9.0/wait -O /wait
    chmod +x /wait
else
    echo "Skipping local setup"
fi