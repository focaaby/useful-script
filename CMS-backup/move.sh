#! /bin/bash

dir="/var/www"
user="www-data"

echo "This is directory $1."
if [ -d $1 ]; then
    echo "Moving $1 to $dir"
    mv $1 $dir/$1 &&
    echo "Changing owner to $user" &&
    chown -R $user:$user $dir/$1 &&
    echo "Changing directory mode to 755..." &&
    find $dir/$1 -type d -exec chmod 755 {} \; &&
    echo "Changing files mode to 644..." &&
    find $dir/$1 -type f -exec chmod 644 {} \;
fi
