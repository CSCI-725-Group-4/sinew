#!/usr/bin/zsh

export PG_ROOT=${1-"/usr/local/pgsql"}
if ! (sudo ls $PG_ROOT/data/global > /dev/null); then
	echo "Initializing postgres"
	su postgres -c "/usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data/"
fi

echo "Running postgres"
# su postgres -c "/usr/local/pgsql/bin/postmaster -D /usr/local/pgsql/data"
su postgres -c "/usr/local/pgsql/bin/postgres -D /usr/local/pgsql/data/"
su postgres -c "/usr/local/pgsql/bin/createdb test"

# # su - postgres
# /usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data/
# /usr/local/pgsql/bin/postmaster -D /usr/local/pgsql/data
# /usr/local/pgsql/bin/createdb test

