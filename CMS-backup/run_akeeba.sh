#! /bin/bash

## 1. Please turn on your akeeba front-end and get your secrect code
## 2. URL
##   - Joomla: http://[yourdomain]/index.php?option=com_akeeba&view=backup&key=[your secrect code]
##   - WordPress: http://[yourdomain]/wp-content/plugins/akeebabackupwp-core/app/index.php?&view=remote&key=[your secrect code]
##


Date=$(date +"%Y%m%d")

run_akeeba() {
    echo "Starting akeeba backup..."
    # wget --max-redirect=10000 "http://www.yoursite.com/index.php?option=com_akeeba&view=backup&key=YourSecretKey"
}

# start funciton

run_akeeba
