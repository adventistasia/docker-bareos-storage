#!/bin/bash

if [ ! -f /etc/firstrun ]
then
        if [ ! -f /etc/bareos/bareos-sd.conf ]
        then
                tar xfvz /etc.tgz
        fi

        # correct owner of volume
        chown bareos /var/lib/bareos/storage

        # optimize configuration
        #export BUILD_NAME=$(grep -iR -m 1 "Name = " /etc/bareos/bareos-sd.conf | awk '{ split($3, x, "-"); print x[1] }')

        #sed -i "s/$BUILD_NAME-\(dir\|sd\|fd\|mon\)/bareos-\1/" /etc/bareos/bareos-sd.conf

        # cleanup        
        touch /etc/firstrun

        rm /etc.tgz
fi

exec "$@"
