#!/bin/sh

export PG_ROOT=/usr/local/pgsql/bin
export OUT=~/hadapt/results/out/queries
mkdir -p $OUT

# Comment these out if rerunning file (table already made + formatted)
echo "Loading data"
$PG_ROOT/psql test -f load_data >> $OUT/load_data.out
# "Upgrading" the data converts it from the json records to the schema
echo "Upgrading data"
$PG_ROOT/psql test -f upgrade >> $OUT/upgrade.out

for query in `ls queries`; do
  echo "QUERY $query"
  mkdir -p $OUT/$query
  for i in 1 2 3 4; do
    $PG_ROOT/psql test -f queries/$query | grep '^Time:' | sed "s/^$i: /" >> $OUT/$query/$query.out
  done
  echo "==========="
  echo
done

# Uncomment this line if you want to drop table after
# $PG_ROOT/psql test -f drop_table
