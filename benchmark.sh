#!/bin/bash
# Benchmark script.
set -e
logfile="benchmark.log"

# Set up a named pipe for logging
npipe=/tmp/$$.tmp
mknod $npipe p

# Log all output to a log for error checking
tee <$npipe $logfile &
exec 1>&-
exec 1>$npipe 2>&1
trap "rm -f $npipe" EXIT

function file_exists() {
    [ -f "$1" ]
}

# Basic distro detection
DISTRO=
if file_exists /etc/debian_version ; then
    DISTRO='debian'
elif file_exists /etc/system-release; then
    DISTRO='rpm'
fi

# Proper distro detection - for Ansible
DISTRO_ID=$(
python - <<EOF
import platform ; print platform.dist()[0].lower()
EOF
)

DISTRO_VERSION=$(
python - <<EOF
import platform ; print int(float(platform.dist()[1]))
EOF
)

function on_error() {
    printf "\033[31m
It looks like you hit an issue when trying to run the benchmark script\n\033[0m\n"
}
trap on_error ERR

if [ -n "$NAME" ]; then
    name=$NAME
fi

if [ ! $name ]; then
    printf "\033[31m Please provide a name for this benchmark. Your results are going to be saved using the name provided - 
    name-diskio.txt, name-mysql.txt, name-cpu.txt, ect. .\033[0m\n"
    exit 1;
fi


# Root user detection
if [ $(echo "$UID") = "0" ]; then
    sudo_cmd=''
else
    sudo_cmd='sudo'
fi



function install_dependecies() {
   
    # Install the necessary package sources
    if [ $DISTRO == 'rpm' ]; then
        echo -e "\033[34m\n* RPM distros not supported \n\033[0m"

      
    elif [ $DISTRO == 'debian' ]; then
        printf "\033[34m\n* Installing dependecies for Debian \n\033[0m\n"       
        $sudo_cmd apt-get update
        $sudo_cmd apt-get install -y --force-yes fio sysbench

    else
        printf "\033[31mYour OS or distribution are not supported by this install script.\033[0m\n"
        exit;
    fi


}

function run_benchmarks(){
    
    printf "\033[34m\n* Running Disk I/O benchmark ...\n\033[0m\n"
   
}

# Show a message about where to go for help.
function print_troubleshooting_instructions() {


printf "\033[32m All done.
   ----------------------------------
\033[0m"


}


install_dependecies
run_benchmarks
print_troubleshooting_instructions