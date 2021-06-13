#!/bin/sh
set -e

welcome() {
    if [ "$*" != "" ] ; then
        echo "Error: $*"
    fi
    cat << EOF
-------------------------------------------------------------
|           Edgebox Cloud Image Builder - v0.0.1            |
-------------------------------------------------------------
EOF
}

install() {
    echo "Installing base dependencies"
    apt-get update
    apt-get install -y -qq vim aptitude nano curl git libffi-dev libssl-dev python3 python3-pip samba samba-common-bin avahi-daemon avahi-utils tinc jq
    pip3 -V
    echo "Creating system user and setting defined password"
    useradd -m system
    echo "system:$SYSTEM_PW" | sudo chpasswd
    echo "Installing Docker"
    curl -ksSL https://get.docker.com | sh
    echo "Installing Docker Compose"
    sudo pip3 -v install docker-compose
    echo "Installing yq"
    sudo pip3 -v install yq
    echo "Installing Go"
    export GOLANG="$(curl https://golang.org/dl/|grep armv6l|grep -v beta|head -1|awk -F\> {'print $3'}|awk -F\< {'print $1'})"
    wget https://golang.org/dl/$GOLANG
    sudo tar -C /usr/local -xzf $GOLANG
    rm $GOLANG
    unset GOLANG >> /home/system/.profile
    echo "export PATH=\$PATH:/usr/local/go/bin" >> /home/system/.profile
    echo "Setting up components"
    mkdir /home/system/components
    cd /home/system/components
    mv /tmp/edgeboxctl ./edgeboxctl
    mv ./edgeboxctl/edgeboxctl.service /lib/systemd/system/edgeboxctl.service
    mv /tmp/ws ./ws
    mv /tmp/api ./api
    mv /tmp/apps ./apps
    echo "Building Reverse Proxy and Service Containers Configs"
    cd ws
    # docker-compose up -d
    chmod 757 ws
    mkdir appdata
    sudo chmod -R 777 appdata/
    ./ws -b
    echo "Starting Revere Proxy and Service Containers"
    ./ws -s
	echo "Starting Edgeboxctl"
	sudo systemctl enable edgeboxctl
	sudo systemctl start edgeboxctl
    echo "Edgebox Setup Finished"
}

welcome
install
exit 0
