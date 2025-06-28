#!/bin/bash
set -euo pipefail

# Variables
TEMPFILES="/tmp/webfiles"
URL="https://www.tooplate.com/zip-templates/2098_health.zip"
ART_NAME="2098_health"
WEBROOT="/var/www/html"

cleanup() {
    echo "Cleaning up temporary files..."
    rm -rf "$TEMPFILES"
}
trap cleanup EXIT

install_packages() {
    local packages="$1"
    echo "Installing packages: $packages"
    if command -v yum &>/dev/null; then
        sudo sed -i 's|^mirrorlist=|#mirrorlist=|g; s|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo || true
        sudo yum clean all
        sudo yum makecache fast
        sudo yum install -y $packages
    else
        sudo apt update
        sudo apt install -y $packages
    fi
}

manage_service() {
    local svc="$1"
    echo "Starting and enabling service: $svc"
    sudo systemctl start "$svc"
    sudo systemctl enable "$svc"
}

deploy_artifact() {
    echo "Deploying web artifact..."
    mkdir -p "$TEMPFILES"
    cd "$TEMPFILES"
    wget -q "$URL"
    sudo unzip -o "$ART_NAME.zip" > /dev/null
    sudo cp -r "$ART_NAME"/* "$WEBROOT"
}

restart_service() {
    local svc="$1"
    echo "Restarting service: $svc"
    sudo systemctl restart "$svc"
    sudo systemctl status "$svc" --no-pager
}

main() {
    if command -v yum &>/dev/null; then
        echo "Detected CentOS/RHEL system."
        PACKAGE="httpd wget unzip"
        SVC="httpd"
    else
        echo "Detected Ubuntu/Debian system."
        PACKAGE="apache2 wget unzip"
        SVC="apache2"
    fi

    install_packages "$PACKAGE"
    manage_service "$SVC"
    deploy_artifact
    restart_service "$SVC"

    echo "Deployment complete. Listing $WEBROOT:"
    ls "$WEBROOT"
}

main "$@"
