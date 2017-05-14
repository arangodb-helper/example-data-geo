#!/bin/bash

command="$1"
shift

function known_files () {
    echo
    echo "Known types are:"
    ls -1 /geo_*.csv.xz | sed -e 's:^/geo_\(.*\).csv.xz$:  \1:'
    echo
}

if test -z "$command" -o "$command" = "help"; then
    cat /README
    exit 0
elif test "$command" = "import"; then
    type="$1"
    shift

    input="/geo_${type}.csv.xz"

    if test -z "$type" -o ! -f "$input"; then
	echo "unknown geo file: $input"
	known_files
	echo "use: import TYPE SERVER [NUMBER] [arangoimp options]"
	exit 1
    fi

    number=""

    case "$1" in
	0*|1*|2*|3*|4*|5*|6*|7*|8*|9*)
	    number="$1"
	    shift
	    ;;
    esac


    if test -z "$number"; then
	echo "importing $type with options: $@"
    else
	echo "importing $number lines from $type with options: $@"
    fi

    unxz < "$input" \
    | (
	if test -z "$number"; then
	    cat
	else
	    n=$(expr $number + 1)
	    head -n $n
	fi
    ) \
    | time -p arangoimp "$@" \
	  --type csv \
	  --file -

    exit 0
elif test "$command" = "bash"; then
    exec /bin/bash "$@"
elif test -f "$command"; then
    exec "$command" "$@"
elif test "$command" = "extract"; then
    type="$1"
    shift

    input="/geo_${type}.csv.xz"

    if test -z "$type" -o ! -f "$input"; then
	echo "unknown geo file: $input"
	known_files
	echo "use: extract TYPE [NUMBER]"
	exit 1
    fi

    number=""

    case "$1" in
	0*|1*|2*|3*|4*|5*|6*|7*|8*|9*)
	    number="$1"
	    shift
	    ;;
    esac


    if test -z "$number"; then
	echo "extracting $type"
    else
	echo "extracting $number lines from $type"
    fi

    cd /data
    unxz -c "$input" \
    | (
	if test -z "$number"; then
	    cat
	else
	    n=$(expr $number + 1)
	    head -n $n
	fi
    ) > geo_${type}.csv

    exit 0
else
    echo "unknown command '$command', known are 'import', 'extract'"
    exit 1
fi
