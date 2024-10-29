#!/usr/bin/zsh

export PG_ROOT=${1-"~/pgsql"}
if ! (sudo ls $PG_ROOT/data/global > /dev/null); then
	echo "Initializing postgres"
	/usr/local/pgsql/bin/initdb -D ~/pgsql/data/
fi

echo "Running postgres"
/usr/local/pgsql/bin/postgres -D ~/pgsql/data/

# This needs to be run it a seperate shell window
# sudo /usr/local/pgsql/bin/createdb test

# # su - postgres
# /usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data/
# /usr/local/pgsql/bin/postmaster -D /usr/local/pgsql/data
# /usr/local/pgsql/bin/createdb test

