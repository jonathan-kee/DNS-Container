Wireshark Full Course
https://www.youtube.com/watch?v=n4muxtqLhN4&t=309s

Wireshark Lua API Course
https://www.youtube.com/watch?v=T8yRoh2Wp5A&list=PLedx6HwQji1O-SHD3_lCdSxMUT56d5y9Y&index=4

Wireshark Lua API Course Git repo
https://bitbucket.org/spandeygit/learn_lua/src/master/

# Introduction 
- Hub will always send request to every computer in the network
- Switch will send request to the target computer instead of every computer in the network

## Spoofing To Obtain Traffic
*** This is ettercap, not sure what is this tbh ***
*** ettercap looks like some software to simulate cyber security stuff ***
*** arpspoof is another tool, not sure what is this tbh ***

## Capturing And Viewing
Loopback interface: lo0 Explanation:
Just local only traffic, that's only network messages that are going 
from this system to this system on a special loopback interface

# Capture Options

## Capture Options*
Each interface like 
- Ethernet: en0
- Loopback: lo0
- Wi-Fi: en1 
Has IPv4 & IPv6 addresses

Question: What is Pipes?
Question: What is Remote Interfaces?

Wireshark can output to below format:
- pcap-ng
- pcap

Different options when you are capturing packets or frames and packets through wireshark.

- Resolve MAC Addresses,
If I resolve the MAC address, you will actually get the name of the vendor
that's associated with the particular network interface

- Resolve network names, 
The network work name would be if you got an ip address,
it would resolve the ip address. So I could go to network names, so I'm not just
looking at IP addresses I'm actually looking at actual host names.

- Resolve transport names, 
I would get the actual name of the port so for eaxmple
instead of just seeing 22 under a port identifier what I would see would be 
SSH if it were a TCP frame that we were looking at.

Resolve network names or transport names will slow the app look up the network names.

## Using Filters
Select an Ethernet: en0
Use filter: host 172.30.42.13
Click on Sharkfin

## Sorting And Searching
Click on the header to do sorting
You can search for keywords next to "Find"

## Viewing Frame Data
Frame is layer 1
Ethernet is layer 2 header
Internet Protocol is layer 3

Question What does layer mean?

Some commentary by speaker:
We have HTTP header at Application later,
UDP, internet protocol, 
We have ethernet header at layer 2

## Changing The View
Plenty of settings to chnage how Wireshark looks

## Streams
Follow -> TCP Stream

Stream is the process of communicating back & fourth
Get all the data that is associated frames that is part of that stream

Red highlight is the message you sent off to the website
Blue highlight is the response

At the expression part:
tcp.stream eq 471
^
Not sure what this part is about 

## Using Dissectors
When you click decode you might get a potential set of rules:
If the TCP port is actually 80 
50360 depends on the source port

## Name Resolution
I do not have reverse DNS resolution set up on my local network
Name Resolution -> turn on "Resolve Network Addresses", Does DNS lookups on all
those IP addresses that it can find and then plugs in names so we've got
"a1755.g.akamai.net" now instead of previous IP address that was there

other thing that we've got going on here is we've got numbers in for 
Port names, I could also specify if I go to the view menu again I could 
resolve transport addresses, the transport layer is our layer 4 and 
that's TCP or UDP so if I were to resolve transport addresses, you are 
going to see those 80s disappear in this column right here and those
should be replaced by HTTP

## Saving Captures
Save as .pcap like below (Safest / default):
filename.pcap

.pcap can be used across a variety of tools

Save as .pcapng for being restricted to Wireshark format

You can also export certain packets instead of all packets
You can also export by filter for packets instead of all packets 