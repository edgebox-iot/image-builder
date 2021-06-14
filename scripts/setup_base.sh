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
    apt-get install -y -qq vim aptitude nano curl git libffi-dev libssl-dev python3 python3-pip samba samba-common-bin avahi-daemon avahi-utils jq
    pip3 -V
    echo "Creating system user and setting defined password"
    useradd -m system
    echo "system:$SYSTEM_PW" | sudo chpasswd
    echo "Installing Docker"
    curl -ksSL https://get.docker.com | sh
    echo "Installing Docker Compose"
    pip3 -v install docker-compose
    echo "Installing yq"
    pip3 -v install yq
    echo "Installing Go"
    wget https://golang.org/dl/go1.16.5.linux-amd64.tar.gz
    tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz
    rm go1.16.5.linux-amd64.tar.gz
    echo "export PATH=\$PATH:/usr/local/go/bin" >> /home/system/.profile
    echo "Setting up components"
    mkdir /home/system/components
    cd /home/system/components
    mv /tmp/edgeboxctl ./edgeboxctl
    cp ./edgeboxctl/edgeboxctl.service /lib/systemd/system/edgeboxctl.service
    cp ./edgeboxctl/edgeboxctl-linux-amd64 /usr/local/sbin/edgeboxctl
    cp ./ws/ws.service /lib/systemd/system/ws.service
    mv /tmp/ws ./ws
    mv /tmp/api ./api
    mv /tmp/apps ./apps
    echo "Building Reverse Proxy and Service Containers Configs"
    cd ws
    chmod 757 ws
    mkdir appdata
    chmod -R 777 appdata/
    ./ws -b
    echo "Starting Reverse Proxy and Service Containers"
    ./ws -s
	echo "Starting Edgeboxctl"
    sudo systemctl daemon-reload
	sudo systemctl enable edgeboxctl
	sudo systemctl start edgeboxctl
    echo "Starting WS"
    sudo systemctl enable ws
    echo "Edgebox Setup Finished"
}

welcome
install
exit 0
