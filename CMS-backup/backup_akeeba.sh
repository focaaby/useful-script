#! /bin/bash

RED='\033[0;31m'
NC='\033[0m'

dir="/var/www"
# your joomla an wordpress dirctories
joomlas=""
wordpresses=""
# akeeba dirctory
j_akeeba="administrator/components/com_akeeba/backup"
wp_akeeba="wp-content/plugins/akeebabackupwp-core/app/backups"

#date=$(date +"%Y%m%d")

run_akeeba() {
    printf "${RED}Starting akeeba backup...${NC}\n"
    cd /tmp/
    # WordPress
    wget --max-redirect=10000  "http://your.domain.com/wp-content/plugins/akeebabackupwp-core/app/index.php?&view=remote&key=5CxMe7JtMIttcUky7c6FVV1Vq19Co8Pd"
    # Joomla
    wget --max-redirect=10000 "http://your.domain.com/index.php?option=com_akeeba&view=backup&key=kBka9pWxT6SRXIrksCrSapnKQZp4wGJX"
    rm index.php* && cd ~/
}

ls_akeeba() {
    printf "List all backup dirctories...\n"
    for joomla in $joomlas 
    do
        printf "${RED}Directory is $dir/$joomla ${NC}\n"
        if [ -d "$dir/$joomla/$j_akeeba" ]; then
            ls -alh --group-directories-first "$dir/$joomla/$j_akeeba"
        fi
    done
}

ls_gdrive() {
    for f in $joomlas
    do
        gdir=$(gdrive list -q "name='$f'" | grep "$f" | awk '{print $1}')
        printf "${RED}dir: $f, Google dirve id is $gdir ${NC}\n"
    done
}

backup_akeeba() {
    for joomla in $joomlas 
    do
        printf "${RED}Directory is $dir/$joomla ${NC}\n"
        if [ -d "$dir/$joomla/$j_akeeba" ]; then
            backup_file=$(latest_file "$dir/$joomla/$j_akeeba")
            #echo "$backup_file"
            gdir=$(gdrive list -q "name='$joomla'" | grep "$joomla" | awk '{print $1}')
            gdrive upload --no-progress "$dir/$joomla/$j_akeeba/$backup_file" -p "$gdir" >> gdrive.log 2>> gdrive.err
        fi
    done
}

latest_file() {
    file=$(ls $1 -tr | grep -E "(zip|jpa)" | awk 'NR==3{print $1}')
    echo "$file"
}

# start funciton

#ls_akeeba
#ls_gdrive
#run_akeeba
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
else
    run_akeeba
    backup_akeeba
fi
