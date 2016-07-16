#!/bin/bash

REPOSITORY=file:///home/ssledz/crypt/svn_repository
SVN_SYN=~/.svn-syn

    if [ ! -e $SVN_SYN ]; then
      touch $SVN_SYN
    fi

    DIRS=`cat $SVN_SYN`

    usage(){
    echo "svn-syn [st|status|ci|commit|a|add|l|list|lo|log|co|checkout|rm|remove]"
    echo "The repository must be mounted"
    echo "Syn dirs: ($DIRS)"
    }

    if [ -z $1 ]
    then
            usage
            exit
    fi

    case "$1" in
            "st" | "status" )
	            for dir in ${DIRS[@]}; do
                    svn st $dir
		    done;
                    ;;
            "ci" | "commit" )
		    for dir in ${DIRS[@]}; do
                    svn ci -m "svn-syn $dir" $dir;
                    done;
                    ;;
            "u" | "up" )
                    for dir in ${DIRS[@]}; do
                    svn up $dir;
                    done;
                    ;;
            "a" | "add" )
                    for dir in ${DIRS[@]}; do
                         for file in `svn st $dir | grep '?'`; do
                              echo $file | grep -v '?' | xargs svn add 2>/dev/null; 
                         done;
                    done;
                    ;;
            "l" | "list" )
                    tmp=''
                    if [ -n $2 ]; then
                       tmp="/$2"
                    fi 
                    svn list $REPOSITORY$tmp
                    ;;
            "lo" | "log" )
                    tmp="$REPOSITORY"
                    if [ $2 != '' ]; then
                       tmp="$2"
                    fi
                    svn log $tmp
                    ;;
	    "co" | "checkout" )
                    if [ $# -le 2 ]; then
                       echo "what where"
                       exit 0
                    fi
                    svn co $REPOSITORY/$2 $3 
                    DIRS=$DIRS" "`pwd`"/"$3 
                    echo `echo $DIRS | sed -e 's/ */ /'` > $SVN_SYN
                    cat $SVN_SYN
                    ;;
            "rm" | "remove" )
                    if [ $# -le 1 ]; then
                       echo "what"
                       exit 0
                    fi
                    echo $2
                    echo `cat $SVN_SYN | sed -e "s/ *[^ ]*$2 */ /" | sed -e 's/ */ /'` > $SVN_SYN
		    cat $SVN_SYN
                    ;;
            * )
                    usage
                    ;;
    esac
