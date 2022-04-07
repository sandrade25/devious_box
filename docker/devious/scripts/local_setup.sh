if [[ $1 == "local" ]]
then
    cp /srv/circus_local.ini /srv/circus.ini
    rm /srv/circus_local.ini

    git fetch --all

    apt-get install postgresql -y

    git clone https://github.com/eradman/ephemeralpg.git && cd ephemeralpg
    make install

    mv /tmp/postgresql.conf /var/lib/postgresql/13/main/postgresql.conf

else
    echo "Skipping local setup"
fi