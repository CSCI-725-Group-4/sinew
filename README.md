# Sinew

All testing has been done in WSL Ubuntu. Any other installs may not work.

## Installing

To install the source code with postgres 9.3.0 (To be updated), run the following command from the user's root (`cd ~`):

Running this should install the full system for you
There are some things to be made aware of:

1. At points, it will ask for your password, this is for some sudo commands for installs and setting up the file structure
2. There will a come a time when it asks for a new password, this is the postgres user's password. Please keep that in mind.
3. After the user's password is entered, you will be asked for 5 items (Full Name, Room Number, Work Phone, Home Phone, Other) when these pop up, just press enter to use the defaults. If you press enter after Other and nothing happens, type `y` and press enter. This should continue the install.
4. After creating the user, it will ask for a new password again. For some reason, we are resetting the password right after making it, so just put in the same password as you gave 'postgres' before.

If something goes wrong, the output is logged in the sinew_install.log file, so we can compare outputs with that.

```bash
{
  date '+%Y-%m-%d %H:%M:%S' \
  && echo "Starting installation..." \
  && git clone https://github.com/CSCI-725-Group-4/sinew.git \
  && sudo apt-get update \
  && sudo apt install zsh -y \
  && cd sinew/ \
  && zsh install.sh \
  && export PATH=/usr/local/pgsql/bin/:$PATH \
  && echo "SUCCESS: Installation completed successfully!"
} 2>&1 | tee -a sinew_install.log
```

## Running

This should be running the postgres service and creating a test DB but the program is seg faulting when it boots up. It could be the old version, it could be the sinew packages, it could be something I'm doing wrong, lots of options...

```bash
{
  date '+%Y-%m-%d %H:%M:%S' \
  && echo "Trying to run the DB..." \
  && cd sinew/ \
  && zsh run.sh \
  && echo "SUCCESS: DB Ran successfully!"
} 2>&1 | tee -a sinew_install.log
```

## Testing

The below set of commands tries to run some small tests, they're seg faulting, gotta fix that.

```bash
{
  date '+%Y-%m-%d %H:%M:%S' \
  && echo "Starting Database Setup..." \
  && cd sinew/benchmark/microbenchmark \
  && zsh test.sh \
  && echo "SUCCESS: Setup completed successfully!"
} 2>&1 | tee -a sinew_install.log
```
