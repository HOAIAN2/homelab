#!/bin/sh

if [ -z "$USERS" ]; then
    USERS="alpineftp|alpineftp"
fi

for i in $USERS; do
    NAME=$(echo $i | cut -d'|' -f1)
    PASS=$(echo $i | cut -d'|' -f2)

    GROUP=$NAME
    FOLDER="/home/$NAME"

    # Skip if user already created (restart always mode)
    if id "$1" >/dev/null 2>&1; then
        continue;
    fi

    echo -e "$PASS\n$PASS" | adduser -h $FOLDER -s /sbin/nologin $UID_OPT $GROUP_OPT $NAME
    mkdir -m 750 -p $FOLDER
    chown $NAME:$GROUP $FOLDER
    unset NAME PASS GROUP FOLDER
done

if [ "$ANONYMOUS_ENABLE" = "YES" ]; then
    sed -i 's/^anonymous_enable=NO/anonymous_enable=YES/' /etc/vsftpd/vsftpd.conf
fi

if [ -z "$PASSIVE_MIN_PORT" ]; then
    PASSIVE_MIN_PORT=10090
    sed -i "s/^pasv_min_port=10090/pasv_min_port=$PASSIVE_MIN_PORT/" /etc/vsftpd/vsftpd.conf
fi

if [ -z "$PASSIVE_MAX_PORT" ]; then
    PASSIVE_MAX_PORT=10100
    sed -i "s/^pasv_max_port=10100/pasv_max_port=$PASSIVE_MAX_PORT/" /etc/vsftpd/vsftpd.conf
fi

vsftpd /etc/vsftpd/vsftpd.conf
