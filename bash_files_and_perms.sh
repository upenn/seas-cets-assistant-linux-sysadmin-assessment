#!/usr/bin/env bash

# bash_files_and_perms.sh

segmentsdone=()
segmentno=1
functionname=""
function nextsegment() {
        echo
        echo "function $functionname segment $segmentno ----------------"
        segmentsdone+=( "$functionname($segmentno)" )
        segmentno=$((segmentno + 1))
}

oumask=$(umask)
opwd=$(pwd)
function resetall() {
	umask $oumask
	cd $opwd
	segmentno=1
}

function files() {
	functionname="files"
        umask 0000

	nextsegment
	rm authfile 2> /dev/null
	ls -la authfile

	echo "username gandalf" > authfile
	echo "password youshallnotpassword" >> authfile

	nextsegment
	ls -la authfile

	nextsegment
	chmod 0600 authfile
	ls -la authfile

	nextsegment
	cat authfile

	nextsegment
	grep username authfile

	rm authfile 2> /dev/null
	resetall
}

function permissions() {
	functionname="permissions"
        umask 0777

        nextsegment
	echo 1 > 1
	echo 2 > 2
	echo 3 > 3
	echo 4 > 4
	chmod u=rw,o=r 1
	chmod u=rw,g=r 2
	chmod g=r      3
	chmod u=rw,o=r 4
	sudo chown root 2 4
        ls -la ?
        cat ?

        sudo rm ?
	resetall
}

function directories() {
	functionname="directories"
	umask 0777

        nextsegment
        mkdir -m 0750 ./a
        mkdir -m 0710 ./a/b
        mkdir -m 0700 ./a/b/c
	ls -l ./a/b

        nextsegment
        cd ./a
        touch afile
        cd ./b
        touch bfile
        cd ./c
        touch cfile
	chmod g+r cfile
        ls -l

        nextsegment
        cd ../..
        ls -l

	resetall
        rm -fr a
}
      
#files
#permissions
#directories

echo
echo "segments done: ${segmentsdone[@]}"
