#!/bin/sh
set -e

welcome() {
    if [ "$*" != "" ] ; then
        echo "Error: $*"
    fi
    cat << EOF
-------------------------------------------------------------
|    Edgebox Cloud Image Builder: DigitalOcean - v0.0.1     |
-------------------------------------------------------------
EOF
}

install() {
    echo "----> Installing base dependencies"
    echo ""
    sh -c DEBIAN_FRONTEND=noninteractive apt-get install -y -qq vim aptitude nano curl git libffi-dev libssl-dev python3 python3-pip samba samba-common-bin avahi-daemon avahi-utils tinc jq >/dev/null
    echo ""
    echo "----> Creating system user and setting defined password:"
    echo ""
    useradd -m system
    echo "system:$SYSTEM_PW" | sudo chpasswd
    echo ""
    echo "----> Installing Docker:"
    echo ""
    curl -ksSL https://get.docker.com | sh
    echo ""
    echo "----> Installing Docker Compose:"
    echo ""
    sh -c DEBIAN_FRONTEND=noninteractive apt-get install -y -qq pip3 >/dev/null
    sudo pip3 -v install docker-compose
    echo ""
    echo "----> Installing yq:"
    echo ""
    sudo pip3 -v install yq
    echo ""
    echo "----> Installing Go:"
    export GOLANG="$(curl https://golang.org/dl/|grep armv6l|grep -v beta|head -1|awk -F\> {'print $3'}|awk -F\< {'print $1'})"
    wget https://golang.org/dl/$GOLANG
    sudo tar -C /usr/local -xzf $GOLANG
    rm $GOLANG
    unset GOLANG
    echo "" >> /home/system/.profile
    echo "export PATH=\$PATH:/usr/local/go/bin" >> /home/system/.profile
    echo ""
    echo "----> Setting up components"
    echo ""
    mkdir /home/system/components
    cd /home/system/components
    mv /tmp/edgeboxctl ./edgeboxctl
    mv ./edgeboxctl/edgeboxctl.service /lib/systemd/system/edgeboxctl.service
    mv /tmp/ws ./ws
    mv /tmp/api ./api
    mv /tmp/apps ./apps
    echo ""
    echo "----> Building Reverse Proxy and Service Containers Configs"
    echo ""
    cd ws
    # docker-compose up -d
    chmod 757 ws
    mkdir appdata
    sudo chmod -R 777 appdata/
    ./ws -b
    echo ""
    echo "----> Starting Revere Proxy and Service Containers"
    echo ""
    ./ws -s
	echo ""
	echo "----> Starting Edgeboxctl"
	sudo systemctl enable edgeboxctl
	sudo systemctl start edgeboxctl
    echo ""
    echo "---------------------------"
    echo "| Edgebox Setup Finished  |"
    echo "---------------------------"
    echo ""
}

welcome
install
exit 0
