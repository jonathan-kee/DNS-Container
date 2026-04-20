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

Question: What does Record Name, Record Types, and the rest of the fields mean?

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

Step 1, c.
type set q=ns and press ENTER, which will set the query type to NS, 
the name server DNS resource record type that identifies authoritative DNS
servers (DNS servers that have zone files to consult for responses 
instead of using a cache like a local DNS server does, querying for its clients).

Question: What does NS (name server) mean?

Step 2,
At the > prompt, type com. and press ENTER Notice, as shown
in Figure 9-4, that it’s com followed by . and not .com (with the dot
before com). The . at the end prevents your system from appending
anything after this (which it could do based on your configuration),
and it’s the proper way to end an FQDN. Furthermore, queries never
begin with a . (as in .com).

Step 4,
At the > prompt, type set q=mx and press ENTER. Now,
instead of the NS (name server) records for the domain, nslookup
will display the MX (mail exchange) resource records, which identify
a domain’s mail servers. Once again, one at a time, execute queries
for (without the commas) rit.edu., flcc.edu., syr.edu., and
naz.edu. (without the commas, but with the dots at the end). What do
you see as output?

Question: What does mx (mail exchange) mean?

Step 5,
At the > prompt, type set q=a and press ENTER. Now
nslookup will show the A (IPv4 address) resource record(s) for each
query. Type www.rit.edu. (with or without the dot at the end this time)
and press ENTER to get the IPv4 address of the RIT Web server.

Question: What does A (IPv4 address) mean?

*** Still left some text ***

Step 6, 
At the > prompt, type set q=aaaa and press ENTER. Now,
nslookup will show the AAAA (IPv6 address) resource record(s) for
each query. Type www.rit.edu. (with or without the dot at the end this
time) and press ENTER to get the IPv6 address of the RIT Web
server. What is the IPv6 address of the RIT Web server? IPv6
addresses are four times the length of IPv4 records (32 × 4 = 128),
which is why this DNS resource record was named AAAA.

Question: What does AAAA (IPv6 address) mean?

Step 7, 
With nslookup, you can change the DNS server from your
default DNS server that the queries go to by default by simply typing
server followed either by the IP address or FQDN of another DNS
server.

Type server 8.8.8.8 or server 8.8.4.4 to have any subsequent
queries through nslookup go to one of these Google Public DNS
Servers. Then execute a few of the earlier queries (see Figure 9-6).
Where can you see proof that the queries went to the new servers in
both the command prompt and Wireshark?

Question: What is 8.8.8.8 or 8.8.4.4 Ip addresses?

Step 8, 
As shown in earlier steps, the queries for NS and MX
records return FQDNs, not IP addresses. What if you wanted the
actual IP addresses for DNS servers and mail servers? Simple!
Execute a query to find out the FQDN of the server first, and then
take the answer that comes back in a DNS response and use that as
the question in a DNS query for either an A or AAAA record!

a. Find the FQDN of a DNS server from a domain, and then find its IP address.
b. Find the FQDN of a mail server from a domain, and then find its IP address.

Step 9,
At the > prompt, type set q=ptr and press ENTER. Now,
nslookup will display the PTR (pointer) resource records. In essence,
PTR resource records are the inverse of A and AAAA records, as
they map a given IP address (either IPv4 or IPv6) to an FQDN. Type
129.21.1.40 and press ENTER. Notice in the output that the answer is
the FQDN web01www01.rit.edu (the CNAME for www.rit.edu), which
you saw earlier mapped to 129.21.1.40. Also notice that the octets of
the IP address in the query are in reverse order with a TLD of in-
addr.arpa, which is the TLD for DNS reverse zones. In order to use
IP addresses in DNS this way, the IP address must be inverted. The
reason why is very interesting. DNS goes from the more specific to
the more general, for example, www (the hostname) to flcc (the
second-level domain, SLD) to edu (the TLD). As you learned in
Chapter 6, IP addresses go from the more general (the network ID)
to the more specific (host ID). As a result, IP addresses have to be
reformatted to be used in a reverse lookup zone hierarchy.

Step 10 
Answer either what’s being asked for (DNS query) or
what’s being returned (DNS response) in DNS. Choose from the
following choices for each RR (resource record) type, which can be
used more than once:
• FQDN
• IPv4 address
• IPv6 address
• domain
• Either an IPv4 or an IPv6 address

Lab Exercise 9.03: DNS Client and DNS Server
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