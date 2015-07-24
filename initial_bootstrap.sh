#! /bin/sh -ex

sudo apt update
sudo apt install -y ruby2.0

export AUTOPROJ_OSDEPS_MODE=all
cd /home/vagrant
mkdir -p dev
cd dev
if ! test -d autoproj; then
    ruby2.0 ../autoproj_bootstrap git https://github.com/rock-core/buildconf
fi
