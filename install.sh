#!/usr/bin/zsh

export SRC_ROOT=`pwd`/src

# Install GNU readline library
echo "Installing GNU readline"
sudo apt-get install libreadline6 libreadline6-dbg libreadline6-dev
echo ""

# Postgres install
# export PG_ROOT=/usr/local/pgsql
if ! which psql > /dev/null ; then
    echo "Installing postgres"
    cd /tmp
    wget http://ftp.postgresql.org/pub/source/v9.3beta2/postgresql-9.3beta2.tar.gz
    tar -xzf postgresql-9.3beta2.tar.gz
    (cd postgresql-9.3beta2; ./configure -enable-debug && make &&
        sudo make install) || exit 1
    adduser postgres && passwd postgres
    mkdir /usr/local/pgsql/data
    sudo chown postgres:postgres /usr/local/pgsql/data
    su - postgres
    /usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data/
    echo ""
fi

# Update postgres extensions
echo "Updating Postgres extensions"
echo ""

echo "Document extension"
export PG_ROOT=$SRC_ROOT/../../postgresql-9.3beta2 # TODO: change me
rm -rf $PG_ROOT/contrib/document
cp -r $SRC_ROOT/postgres/document $PG_ROOT/contrib/document || exit 1
(cd $PG_ROOT/contrib/document;
   (cd lib/jsmn; make) && make && sudo make install) || exit 1
echo ""

exit 0;

echo "Installing ant"
# Install ant
sudo apt-get install ant || exit 1

echo "Installing solr"
# Solr install
export SOLR_ROOT=/usr/local/solr-4.4.0
cd /tmp
wget http://www.poolsaboveground.com/apache/lucene/solr/4.4.0/solr-4.4.0-src.tgz
tar -xzf solr-4.4.0-src.tgz
(cd solr-4.4.0; ant compile) || exit 1
mv solr-4.4.0/example /usr/local/solr-4.4.0

# Copy solr configurations
# TODO:
cp SRC_ROOT/config/schema.xml /usr/local/example/config/schema.xml
cp SRC_ROOT/config/data-config /usr/local/example/config/data-config.xml
