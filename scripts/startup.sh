#!/bin/bash

#add sudo user for troubleshooting
adduser servapp
echo servapp:serv@app | chpasswd
usermod -aG sudo servapp

# update and install required software
apt-get update
apt-get install -yq git supervisor jq

# Install Go Manually
wget https://go.dev/dl/go1.18.1.linux-amd64.tar.gz

sudo tar -C /usr/local -xzf go1.18.1.linux-amd64.tar.gz

# Set the Export Path for Go
export PATH=$PATH:/usr/local/go/bin
source ~/.bashrc

# Git TechChallengeApp source code and Build
mkdir /opt/app
cd /opt/app
git clone https://github.com/servian/TechChallengeApp.git /opt/app/TechChallengeApp

chmod -R 777 /opt/app/TechChallengeApp

cd /opt/app/TechChallengeApp

git config --global --add safe.directory /opt/app/TechChallengeApp

sudo /usr/local/go/bin/go build

# secrets URI is of the form projects/$PROJECT_NUMBER/secrets/$SECRET_NAME/versions/$SECRET_VERSION
secretUri=$(curl -sS "http://metadata.google.internal/computeMetadata/v1/instance/attributes/secret-id" -H "Metadata-Flavor: Google")

# split into array based on `/` delimeter
IFS="/" read -r -a secretsConfig <<< "$secretUri"

# get SECRET_NAME and SECRET_VERSION
SECRET_NAME=${secretsConfig[3]}
SECRET_VERSION=${secretsConfig[5]}

# access secret from secretsmanager
secrets=$(gcloud secrets versions access "$SECRET_VERSION" --secret="$SECRET_NAME")

# set secrets as enviroment varialble
export $(echo "$secrets" | jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]")

# Create the database & Start application
cd /opt/app/TechChallengeApp
./TechChallengeApp updatedb -s
./TechChallengeApp serve
