#! /bin/bash

echo "This is directory $1.\n"
for f in $(ls $1)
do    
    echo "$f is convering to UTF-8..."
    enconv -L zh -x utf8 $1/$f
    #iconv -f BIG-5 -t UTF-8 $1/$f  > $1-UTF8/$f
done
