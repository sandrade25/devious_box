if [[ $1 == "local" ]]
then
    cp /srv/circus_local.ini /srv/circus.ini
    rm /srv/circus_local.ini

    git fetch --all
    pip install -r /var/www/trivie-server/requirements-dev.txt
else
    echo "Skipping local setup"
fi