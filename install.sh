#!/usr/bin/zsh

export SRC_ROOT=~/sinew/src

# Install Some Additional Deps
echo "Installing Deps"
sudo apt-get install libreadline-dev zlib1g-dev build-essential nmap -y
echo ""

# Postgres install
export PG_ROOT=${1-"/usr/local/pgsql"}
if ! (ls $PG_ROOT > /dev/null); then
    echo "Installing postgres"
    cd /tmp
    wget https://ftp.postgresql.org/pub/source/v9.3.0/postgresql-9.3.0.tar.gz
    tar -xzf postgresql-9.3.0.tar.gz
    (cd postgresql-9.3.0; ./configure -enable-debug && make &&
        sudo make install) || exit 1
    echo "Install Complete!"
fi

if ! (ls $PG_ROOT/data > /dev/null); then
    echo "Creating postgres User"
    (sudo adduser postgres && sudo passwd postgres &&
    sudo mkdir $PG_ROOT/data &&
    sudo chown postgres:postgres $PG_ROOT/data) || exit 1
    echo "User Created!"
fi

# Update postgres extensions
echo "Updating Postgres extensions"
echo ""
export PG_ROOT=/tmp/postgresql-9.3.0/ # TODO: change me

echo "Document extension"
rm -rf $PG_ROOT/contrib/document
cp -r $SRC_ROOT/postgres/document $PG_ROOT/contrib/document || exit 1
(cd $PG_ROOT/contrib/document;
   (cd lib/jsmn; make) && make && sudo make install) || exit 1
echo ""

echo "Schema Analyzer"
rm -rf $PG_ROOT/contrib/schema_analyzer
cp -r $SRC_ROOT/postgres/schema_analyzer $PG_ROOT/contrib/schema_analyzer || exit 1
(cd $PG_ROOT/contrib/schema_analyzer; make && sudo make install) || exit 1
echo ""

exit 0;
echo "Column Upgrader"
rm -rf $PG_ROOT/contrib/bw_colupgrader
cp -r $SRC_ROOT/postgres/bw_colupgrader $PG_ROOT/contrib/bw_colupgrader || exit 1
(cd $PG_ROOT/contrib/bw_colupgrader; make && sudo make install) || exit 1
echo ""


echo "Installing ant"
# Install ant
sudo apt-get install ant || exit 1

echo "Installing solr"
# Solr install
export SOLR_ROOT=/usr/local/solr-4.4.0
cd /tmp
wget https://archive.apache.org/dist/lucene/solr/4.4.0/solr-4.4.0-src.tgz
tar -xzf solr-4.4.0-src.tgz
(cd solr-4.4.0; ant compile) || exit 1
mv solr-4.4.0/example /usr/local/solr-4.4.0

# Copy solr configurations
# TODO:
cp SRC_ROOT/config/schema.xml /usr/local/example/config/schema.xml
cp SRC_ROOT/config/data-config /usr/local/example/config/data-config.xml
