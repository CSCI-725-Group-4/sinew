#!/bin/bash

HOME=`pwd`
OUT='/tmp/dtahara/out'

mkdir -p $OUT

# TODO: add these back
# for ser in sinew protobuf avro; do
for ser in sinew; do
  cd $ser
  mkdir -p /tmp/dtahara/$ser
  make clean
  make
  for i in 1 2 3 4; do
    make test >> $OUT/$ser.out
    rm -f /tmp/dtahara/$ser/*
  done
  cd $HOME
done

