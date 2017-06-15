#!/bin/bash

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin


set -e

LOCKFILE=/var/run/backup/backup.lock
PID=$$

#Variables
FULLTEMPDIR="/tmp/<%=@hostname%>/$3"
DBSPECIFIEDDBNAMES=$4
DIRSPECIFIEDDBNAMES=$4
BACKUPNAME=$3

#Program inicialization
mkdir -p $(dirname $LOCKFILE)
touch $LOCKFILE
exec 200>$LOCKFILE
flock -x -n 200
echo -n $PID >$LOCKFILE

debug() {
        echo -n -e '\e[34m'
        echo -n $1
        echo -n -e '\e[0m'
}

debugln() {
        echo -n -e '\e[34m'
        echo -n $1
        echo -e '\e[0m'
}

status() {
        echo -n [ $(date +"%Y-%m-%d %H:%M:%S %Z") ] $1
}

statusln() {
        echo $1
}

success() {
        echo -n -e '\e[32m'
        echo -n $1
        echo -n -e '\e[0m'
}

successln() {
        echo -n -e '\e[32m'
        echo -n $1
        echo -e '\e[0m'
}

error() {
	echo -n -e '\e[0m' >&2
	echo -n -e '[ ' 
        echo -n -e '\e[31m' >&2
        echo -n $1 >&2
        echo -n -e '\e[0m' >&2
		echo -e ' ]'
}

errorln() {
        echo -n -e '\e[31m' >&2
        echo -n $1 >&2
        echo -e '\e[0m' >&2
}

warn() {
        echo -n -e '\e[33m' >&2
        echo -n $1 >&2
        echo -n -e '\e[0m' >&2
}

warnln() {
        echo -n -e '\e[33m' >&2
        echo -n $1 >&2
        echo -e '\e[0m' >&2
}


runroot() {
        if [ -z $1 ]; then
                error "No command passed!" >&2
                exit 1
        fi
        if [ $(id -u) -ne 0 ]; then
                errorln "This program cannot be run as non-root user!"
                exit 1
        fi
		sudo --preserve-env -- $*
        return $?
}


databasebackup(){

	if [ "$(/usr/bin/mysqladmin status | awk '{ print $2 }')" -eq 0 ]; then
		errorln 'ERROR! MySQL server NOT RUNNING!';
		exit 1
	fi

	status "Temporary directory ..... "

	if [ ! -d "$FULLTEMPDIR" ]; then
		$(runroot mkdir -p "$FULLTEMPDIR")
		successln " CREATED"
	else
		warnln " ALREADY EXISTS"
	fi

	status "Database backup type ..... "

	if [ $1 == "all" ]; then
	    successln " ALL"
	    DATABASES=$(mysql -N --raw --batch -e "SELECT schema_name FROM information_schema.schemata WHERE schema_name NOT IN ('mysql','information_schema','performance_schema')")
    	    for databasename in $DATABASES; do
	    	status "$databasename database backup ..... "
        	    $(runroot mysqldump --lock-all-tables $databasename > $FULLTEMPDIR/$databasename.sql)
		successln " SUCCESS"
	    done
	elif [ $1 == "specified" ]; then
	    successln " SPECIFIED"
	    while IFS='' read -r databasename || [[ -n "$databasename" ]]; do
		status "$databasename database backup ..... "
    		    $(runroot mysqldump --lock-all-tables $databasename > $FULLTEMPDIR/$databasename.sql)
		successln " SUCCESS"
    	    done < /root/.duply/<%=@hostname%>-$BACKUPNAME/mysqldatabases.backup
	else
		errorln "DOESN'T EXIST!"
	fi

	duply <%=@hostname%>-$BACKUPNAME backup >/dev/null

	rm -Rf $FULLTEMPDIR

}

directorybackup(){

    status "Temporary directory ..... "

    if [ ! -d "$FULLTEMPDIR" ]; then
        $(runroot mkdir -p "$FULLTEMPDIR")
        successln " CREATED"
    else
        warnln " ALREADY EXISTS"
    fi

	while IFS='' read -r directory || [[ -n "$directory" ]]; do
		REPLACEDNAME=$(runroot echo "$directory" | sed -r 's/[/]+/I/g')
		status "$directory name convert to ASCII based string $REPLACEDNAME and compress ..... "
		$(runroot tar czf $FULLTEMPDIR/$REPLACEDNAME.tar.gz $directory)
		successln " SUCCESS"
    done < /root/.duply/<%=@hostname%>-$BACKUPNAME/directory.backup

    duply <%=@hostname%>-$BACKUPNAME backup >/dev/null

    rm -Rf $FULLTEMPDIR

}

case $1 in
	database )
		shift
		databasebackup $*
		exit $?
		;;
	files )
		shift
		directorybackup $*
		exit $?
		;;
	* )
		echo "Usage: backup.sh COMMANDS" >&2
		echo "" >&2
		echo "Commands:" >&2
		echo " database [all | specified] :  backup mysql database to file and compress it" >&2
		echo " files specified fullpatch        :  backup filesystem directory and compress it" >&2
		exit 1
		;;
esac

flock -u 200