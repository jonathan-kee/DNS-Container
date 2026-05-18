#!/bin/bash
###################################
# Prerequisites

# Download the powershell '.tar.gz' archive
echo '----------------curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.6.1/powershell-7.6.1-linux-arm64.tar.gz-------------------'
curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.6.1/powershell-7.6.1-linux-arm64.tar.gz

# Create the target folder where powershell will be placed
echo '----------------sudo mkdir -p /opt/microsoft/powershell/7-------------------'
sudo mkdir -p /opt/microsoft/powershell/7

# Expand powershell to the target folder
echo '----------------sudo tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7-------------------'
sudo tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7

# Set execute permissions
echo '----------------sudo chmod +x /opt/microsoft/powershell/7/pwsh-------------------'
sudo chmod +x /opt/microsoft/powershell/7/pwsh

# Create the symbolic link that points to pwsh
echo '----------------sudo ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh-------------------'
sudo ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh
