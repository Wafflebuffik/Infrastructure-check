#!/bin/bash
set -euo pipefail

#Are u root?
if [[ $EUID -ne 0 ]]; then
        echo "Run command as root"
        exit 1
fi

#env. preperation before installing
apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1) || echo "preparing env. failed..."

# Add Docker's official GPG key:
apt update
apt install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

#packages ver. update
apt update -y


#Installation process

echo "starting processing... installation step 1 [Required Packages]"
apt install -y git curl wget unzip htop tree jq || echo "Installation failed..."
echo "starting processing... installation step 2 [Docker, Docker components]"
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || echo "Installation failed..."

#Setting env process

echo "setting priviliges to user by adding to docker group"
usermod -aG docker $SUDO_USER || echo "adding user to the group failed..."


