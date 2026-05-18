#!/bin/bash
###################################
# Prerequisites

# Update the list of packages
echo '----------------sudo apt-get update-------------------'
sudo apt-get update

# Install pre-requisite packages.
echo '----------------sudo apt-get install -y wget apt-transport-https software-properties-common-------------------'
sudo apt-get install -y wget apt-transport-https software-properties-common

# Get the version of Ubuntu
echo '----------------source /etc/os-release-------------------'
source /etc/os-release

# Download the Microsoft repository keys
echo '----------------wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb-------------------'
wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb

# Register the Microsoft repository keys
echo '----------------sudo dpkg -i packages-microsoft-prod.deb-------------------'
sudo dpkg -i packages-microsoft-prod.deb

# Delete the Microsoft repository keys file
echo '----------------rm packages-microsoft-prod.deb-------------------'
rm packages-microsoft-prod.deb

# Update the list of packages after we added packages.microsoft.com
echo '----------------sudo apt-get update-------------------'
sudo apt-get update

###################################
# Install PowerShell
echo '----------------sudo apt-get install -y powershell-------------------'
sudo apt-get install -y powershell

# Start PowerShell
# pwsh