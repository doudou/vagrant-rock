#! /bin/sh

path=$1
if test -z $path; then
    echo "usage: acl.sh PATH"
    exit 1
fi

setfacl -m group:kvm:rwX -R $path
setfacl -d -m group:kvm:rwX -R $path
