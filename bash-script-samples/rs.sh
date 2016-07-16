# !/bin/bash

# konfiguracja
RAPID_LOGIN="1070444"
#RAPID_PASSWORD='1945x$CvH123&&cvb#$'
RAPID_PASSWORD='1945x$CvH123%26%26cvb#$'
RAPID_DIR="$HOME/.rapidshare"
RAPID_COOKIE_FILE=$RAPID_DIR/.cookies/rapidshare
RAPID_DOWNLOAD_DIR=$RAPID_DIR/"downloads"
RAPID_LOG_FILE=$RAPID_DIR/"rapid.log"
RAPID_CACHE_FILE=$RAPID_DIR/"rapid.cache"
RAPID_DLBASKET=$RAPID_DIR/"dlbasket"
WGET_BIN="/usr/bin/wget"

export RAPID_LOG_FILE

DATETIME="date"

if [ -e $RAPID_COOKIE_FILE ]; then
	echo "$($DATETIME) Ciasteczko z rapidshara istnieje: $RAPID_COOKIE_FILE" >> $RAPID_LOG_FILE
else
	echo "login=$RAPID_LOGIN&password=$RAPID_PASSWORD"
	$WGET_BIN \
		--save-cookies $RAPID_COOKIE_FILE \
                --post-data "login=$RAPID_LOGIN&password=$RAPID_PASSWORD" \
		-O - \
		https://ssl.rapidshare.com/cgi-bin/premiumzone.cgi \
    		> /dev/null
	echo "$($DATETIME) Ciasteczko z rapidshara zainicjowane" >> $RAPID_LOG_FILE
fi

cat <> $RAPID_DLBASKET | 
( 
	while read url; do
		if [ -f $RAPID_CACHE_FILE -a -n $(grep -i $(basename $url) $RAPID_CACHE_FILE) ] ; then
			echo "$($DATETIME) Plik $(basename $url) został już sciągnięty url: $url" >> $RAPID_LOG_FILE
		else
			echo "$($DATETIME) Sciągam plik $(basename $url) url: $url" >> $RAPID_LOG_FILE
			$WGET_BIN -c --directory-prefix=$RAPID_DOWNLOAD_DIR --load-cookies $RAPID_COOKIE_FILE $url 
			echo "$($DATETIME) Plik $(basename $url) url: $url sciągnięty" >> $RAPID_LOG_FILE
                        echo $url >> $RAPID_CACHE_FILE

		fi	
	done
) 
exit 0
