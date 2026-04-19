Lab Exercise 9.01: DNS Queries, DNS Responses, and DNS Resolver Cache

Step 2:
ipconfig /all

Question: Why is the syntax having / ? Instead of - like in Linux?
Question: Does every PC contains DNS resolver cache?

Step 3:
ipconfig /displaydns

"ipconfig /displaydns" Output:

Windows IP Configuration

    download.windowsupdate.com
    ----------------------------------------
    Record Name . . . . . : download.windowsupdate.com
    Record Type . . . . . : 5
    Time To Live  . . . . : 622
    Data Length . . . . . : 8
    Section . . . . . . . : Answer
    CNAME Record  . . . . : download.windowsupdate.com.delivery.microsoft.com


    Record Name . . . . . : download.windowsupdate.com.delivery.microsoft.com
    Record Type . . . . . : 5
    Time To Live  . . . . : 622
    Data Length . . . . . : 8
    Section . . . . . . . : Answer
    CNAME Record  . . . . : wu-f-net.trafficmanager.net

... Quite long list

Step 4:
ipconfig /flushdns
ipconfig /displaydns

"ipconfig /displaydns" Output after "ipconfig /flushdns":

Windows IP Configuration

    client.wns.windows.com
    ----------------------------------------
    Record Name . . . . . : client.wns.windows.com
    Record Type . . . . . : 5
    Time To Live  . . . . : 12098
    Data Length . . . . . : 8
    Section . . . . . . . : Answer
    CNAME Record  . . . . : wns.notify.trafficmanager.net


    Record Name . . . . . : wns.notify.trafficmanager.net
    Record Type . . . . . : 1
    Time To Live  . . . . : 12098
    Data Length . . . . . : 4
    Section . . . . . . . : Answer
    A (Host) Record . . . : 4.213.25.241
    
... Only 2 records compared to previous long list

*** WireShark section ***

Lab Exercise 9.02: nslookup
*** WireShark section ***

Lab Exercise 9.03
Step 1
• IP address: 192.168.1.18
• Subnet mask: 255.255.255.0
• Default gateway: (leave blank)

Step 2
• IP address: 192.168.1.81
• Subnet mask: 255.255.255.0
• Default gateway: (leave blank)
• Preferred DNS server: 127.0.0.1
• Alternate DNS server: (leave blank)

Step 3
*** Not sure what DNS role means ***

Step 6
*** Windows Defender Firewall is involved ***

Lab Exercise 9.01

Lab Exercise 9.01

Lab Exercise 9.01

Chapter 10
- Using a digital certificate from a reputable certificate authority (CA) is a must. 
- Using Secure Shell (SSH) for remote management to encrypt traffic to and from an SSH server is a must. 
- Using Transport Layer Security (TLS) to encrypt traffic to and from a Web server is a must.

Lab Exercise 10.01: Certificate Authorities
*** These are all the CAs (at different hierarchical levels) recognized by Mozilla Firefox. ***
^
I think it will be a good idea to note down all the different CAs

*** These are all the CAs (at different hierarchical levels) recognized by Google Chrome. ***

• IdenTrust
• DigiCert
• Sectigo
• GoDaddy
• GlobalSign
• Let’s Encrypt

Lab Exercise 10.02: Secure Ports, OpenSSH, and TLS
Question: Does Windows 10 not have OpenSSH server & OpenSSH client installed?

Step 3
Question: Does this mean most server software requires firewall rules when installed?

Step 4
Start-Service sshd

Set-Service -Name sshd -StartupType 'Automatic'

Get-NetFirewallRule -Name *ssh*

New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True
-Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

Step 5
tcp.port == 22.

*** I wonder if I can use wireshark as an api to collect sniffing logs ***

Lab Exercise 10.03: Kerberos
*** No idea what this means ***

Lab Exercise 10.04: DoH and DoT

Question: They sound very similar, DoH (DNS over HTTPS) and DoT (DNS over TLS). HTTPS is implemented through TLS, so what is the actual difference?

Step 2 
Enable and configure DoH in Mozilla Firefox.

Step 3
Enable and configure DoH in Google Chrome.

Chapter 13 WAN Connectivity
*** This chapter has a lot of GUI configurations ***

How will employees working from home access the on-premises resources, though? 
How will the corporate data be secured as it travels from an employee’s house to the organization’s infrastructure and back?

Lab Exercise 13.01: VPN

Lab Exercise 13.02: Remote Desktop

Lab Exercise 13.03: Microsoft Quick Assist

Chapter 15 Virtualization and Cloud Computing
*** This chapter should be interesting as it relates to Vagrant & Docker ***
^
I just realize if you want to have multiple of the same ports, VM or Containers are perfect for this

Lab Exercise 15.01: Virtualization Technologies

Lab Exercise 15.02: VMware Workstation Player and Ubuntu
*** Probably have to follow VMware installation with Vagrant ***
*** I realize the labs contains a lot of wireshark usage ***

Lab Exercise 15.03: Traffic Between the Host System and the VM

Lab Exercise 15.04: Traffic from the VM to the Internet

Lab Exercise 15.05: Cloud Computing with Google Drive