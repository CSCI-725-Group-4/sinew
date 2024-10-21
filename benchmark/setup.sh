#!/usr/bin/zsh

export BNCHMRK_ROOT=~/sinew/benchmark/

sudo apt-get install subversion -y

# Install Postgres, etc
zsh $BNCHMRK_ROOT/../install.sh

# TODO: We might need to do some work arounds here, the recent versions are not built for gcc compilation
# (if this is needed, idk if it is)
# git reset dea840bbb6ff5f18616b444b6ebd8278131a1da7 --hard
exit(0)

# Pl/v8 stuff

git clone https://github.com/v8/v8.git v8 && cd v8
export GYPFLAGS="-D OS=freebsd"
make dependencies
make native.check -j 4 library=shared strictaliasing=off console=readline
cp v8.so /usr/lib/v8.so
cd $BNCHMRK_ROOT

# TODO: Add pg_config to you $PATH. Normally pg_config exists in $PGHOME/bin.

git clone https://github.com/plv8/plv8.git && cd plv8js
make && make install

cd $BNCHMRK_ROOT
