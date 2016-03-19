#! /bin/bash

bak_path="[YourBackupPath]"
dir="/var/www"

joomla="administrator/components/com_akeeba/backup"
wp="wp-content/plugins/akeebabackupwp-core/app/backups"

date=$(date +"%Y%m%d")

tar_akeeba() {
    echo "Starting backup"
    for f in $(ls $dir)
    do
        if [ -d $dir/$f/$joomla ]; then
            cd $dir/$f/$joomla
            tar zcvfp $bak_path/$f-$date.tar.gz ./*.zip
        elif [ -d $dir/$f/$wp ]; then
            cd $dir/$f/$wp
            tar zcvfp $bak_path/$f-$date.tar.gz ./*.zip
        else
            echo $dir/$f 'dont have akeeba exist.'
        fi
    done
}

upload_gdir() {
    cd $bak_path
    echo "cd in $bak_path....."
    for f in $(ls $dir)
    do
        gdir=$(./gdrive list -q "name='$f'" | grep "$f" | awk '{print $1}')
        if [ -z "$gdir" ]; then
            echo "$f has no Google dirve id"
            if [ -f $bak_path/$f-$date.tar.gz ]; then
                ./gdrive mkdir $f &&
                echo "Google drive mkdir $f......" &&
                gdir=$(./gdrive list -q "name='$f'" | grep "$f" | awk '{print $1}')
                ./gdrive upload -p $gdir $f-$date.tar.gz &&
                rm $f-$date.tar.gz
            fi
        else
            echo "$f Google dirve id is $gdir, file name is $f-$date.tar.gz"
            ./gdrive upload -p $gdir $f-$date.tar.gz &&
            rm $f-$date.tar.gz
        fi
    done
}


# start funciton

tar_akeeba
upload_gdir
