#!/bin/sh
RED="\033[0;31m"
GREEN="\033[0;32m"
CLR="\033[0;0m"
SPACER="\n_________________________________\n"
BONUS=""
RUN="so_long"
VALGRIND="YES"

if [ "$1" = "bonus" ]; then
	BONUS="_${1}"
    RUN="${RUN}""${BONUS}"
fi

if ! test -f $RUN; then
	echo $RED"no ./$RUN"$CLR
	return
fi

if ! test -d val; then
	echo "creat val dir"
	mkdir val
fi

for entry in `ls maps/err`; do
    echo $SPACER
    echo "./"$RUN $GREEN$entry $CLR 
    echo $RED
    
    if [ "$VALGRIND" = "YES" ]; then
    	valgrind --track-origins=yes --leak-check=full --log-file=val/valgrind_$entry ./$RUN "maps/err/"$entry
    fi
    
    if [ "$VALGRIND" = "NO" ]; then
    	./$RUN "maps/err/"$entry
    fi
    echo $CLR
done

