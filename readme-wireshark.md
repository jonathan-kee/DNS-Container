All mentions of "wireshark" in comptia network+ book
^
Verify now
Pages 20, 

Lab Exercise 1.01: Network Hardware and Software
34, 

Lab Exercise 6.04: Packet Sniffing
161, 163, 164, 165, 166, 167, 168, 171, 173, 

Of course, IP packets, which exist at Layer 3 of the OSI model,
are encapsulated inside of Layer 2 frames. On wired LANs, they are
Ethernet frames. On wireless LANs, they are 802.11 frames. In the
context of capturing and analyzing network traffic, though, even
though the lowest unit to capture and analyze is the frame, it’s still
called packet sniffing.

Question: what is Layer 3 of the OSI model?
Question: What is Layer 2 frames?
Question: What is a frame?

Every single bit, all the 1s and 0s that go in and out of a network interface card (NIC), 
can be seen and analyzed. There is an option to see them in true binary,
even hexadecimal, but as humans, we prefer a format that is more
intuitive. A packet sniffer (also known as a packet analyzer and
protocol analyzer), implemented in software or hardware, will not
only intercept and log all the 1s and 0s moving in and out of a NIC
but show it to us humans in a human-readable format in addition to
binary and hexadecimal. All of the fields of every single frame,
packet, segment, datagram, and upper-layer data will be shown with
their names, along with their corresponding data values. For
example, in the IP packet, you’ll see the source IP address with a
value like 192.168.1.113 and the destination IP address with a value
like 192.168.1.107. You’ll see the content as it’s listed in the RFC or
other specifications.

Question: Why is there software or hardware for alot of networking applications?
Question: What is packet, segment, datagram, upper-layer data?

Packet sniffers can provide so much insight into network traffic.
This impressive list of functions of packet sniffers can be found in
Wikipedia’s “Packet analyzer” entry,
https://en.wikipedia.org/wiki/Packet_analyzer:

• Analyze network problems
• Detect network intrusion attempts
• Detect network misuse by internal and external users
• Document regulatory compliance through logging all perimeter and endpoint traffic
• Gain information for effecting a network intrusion
• Aid in gathering information to isolate exploited systems
• Monitor WAN bandwidth utilization
• Monitor network usage (including internal and external users and systems)
• Monitor data in transit
• Monitor WAN and endpoint security status
• Gather and report network statistics
• Identify suspect content in network traffic
• Troubleshoot performance problems by monitoring network data from an application
• Serve as the primary data source for day-to-day network monitoring and management
• Spy on other network users and collect sensitive information
such as login details or user cookies (depending on any
content encryption methods that may be in use)
• Reverse engineer proprietary protocols used over the network
• Debug client/server communications
• Debug network protocol implementations
• Verify adds, moves, and changes
• Verify internal control system effectiveness (firewalls, access control, Web filter, spam filter, proxy)

Tech Tip
The terms frame and packet are often used interchangeably.
However, this is incorrect. Frames are found at Layer 2 and
encapsulate packets, while packets are found at Layer 3 and
encapsulate ICMP packets, TCP segments, UDP datagrams,
and more. You should use the proper terms!

(LAB)
The magical world of networking uses the same logic. Computing
devices directly deliver messages for other devices on the same
network through switches. Switches connect devices of the same
network together. However, computing devices rely on a router to
communicate with devices on different networks. We’ll see exactly
how routing and switching work in future chapters, but for now, all
you need to know is that switches connect devices of the same
network together and routers connect different networks together.

The source of traffic knows its own MAC address and IP address,
but before any traffic can be sent, that host needs to have a
destination MAC address and a destination IP address to send traffic
to. The host will know the destination’s IP address. It will either just
have that IP address or Domain Name System (DNS), coming up in
Chapter 9, will resolve a fully qualified domain name (FQDN) into its
corresponding IP address. Getting the destination MAC address,
though, is a different story, made possible by a protocol called
Address Resolution Protocol (ARP). In fact, the process differs for
local communication (meant for a device on the same network) and
remote communication (meant for a device on a different network).

Get ready to explore the mechanics of ARP and ICMP (Internet
Control Message Protocol) and dissect network traffic to fully
understand the differences between local communication and
remote communication, as well as understand the relationship
between IP addresses and MAC addresses.

Lab Exercise 6.06: Dynamic IP Address Configuration
188, 190, 

Context/Interpretation of the data:
- The middle section is the Packet Details pane, which displays details of each captured frame.

- The bottom section is the Packet Bytes pane, which shows hexadecimal values of captured data. 

- The right side of the bottom section will show the ASCII/Unicode values for the hex values, 
even if the hex values are not meant to be translated into ASCII/Unicode. When you see a dot, 
it means that there is no ASCII/Unicode equivalent. Other times you’ll see ASCII/Unicode translations that
make no sense because they weren’t meant to be translated, but coincidentally can be interpreted as an ASCII/Unicode character.

Step 3
- When you click a row in the Packet List pane, the Packet Details pane changes to fields and values for all protocols involved in the
row you selected in the Packet List pane. When you click a field/value in the Packet Details pane, the Packet Bytes pane will
highlight the corresponding hex digits and ASCII/Unicode representation. You can even turn that hex into binary by right-
clicking in the Packet Bytes pane and selecting …As Bits.

Step 7
Question: What is promiscuous mode?
*** Apparently wireshark can track broadcast request like ARP request ***
*** Apparently wireshark can track unicast request like ARP reply ***


Lab Exercise 6.07: DHCP Client and DHCP Server
197, 

Lab Exercise 7.01: tracert
202, 204, 205, 206, 207, 209, 

Lab Exercise 7.02: NAT and Port Forwarding
217, 219, 

Lab Exercise 8.03: HTTP
235, 240, 241, 

Lab Exercise 8.04: FTP
242, 245, 248, 249, 

Lab Exercise 8.05: The TCP Three-Way Handshake and Beyond
250, 251, 257, 

Lab Exercise 9.01: DNS Queries, DNS Responses, and DNS Resolver Cache
262, 264, 265, 266, 267, 268, 

Lab Exercise 9.02: nslookup
270, 274, 276, 

Lab Exercise 9.03: DNS Client and DNS Server
282, 283, 

Lab Exercise 10.02: Secure Ports, OpenSSH, and TLS
291, 295, 297, 299, 300, 

Lab Exercise 11.04: SPAN
338, 

Lab Exercise 12.03: IPv6 Configuration and Communication
354, 359, 

Lab Exercise 12.04: IPv6 Neighbor Discovery Protocol (RS, RA)
360, 

Lab Exercise 12.05: IPv6 Neighbor Discovery Protocol (NS, NA)
368, 369, 370, 371, 372, 375, 377, 

Lab Exercise 13.01: VPN
385, 386, 387, 389, 390, 

Lab Exercise 13.02: Remote Desktop
395, 

Lab Exercise 15.03: Traffic Between the Host System and the VM
430, 432, 433, 434, 435, 436, 

Lab Exercise 15.04: Traffic from the VM to the Internet
439, 440 


Page 34
Enter the MAC address of your NIC into the Wireshark OUI
Lookup tool here to see the organization that made your NIC:
https://www.wireshark.org/tools/oui-lookup.html.

Lab Exercise 6.04: Packet Sniffing, (Start at Page 161)
While there are a few dozen packet sniffers, some with
specialized purposes, there is one that stands above the rest. From
Wireshark’s Web site (https://www.wireshark.org/):

Wireshark is the world’s foremost and widely-used network
protocol analyzer. It lets you see what’s happening on your
network at a microscopic level and is the de facto (and often
de jure) standard across many commercial and non-profit
enterprises, government agencies, and educational
institutions. Wireshark development thrives thanks to the
volunteer contributions of networking experts around the globe
and is the continuation of a project started by Gerald Combs in
1998.

In this lab exercise, you’ll install and run the Wireshark packet sniffer
application, use it to capture data from your network, and examine
the captured data. By the end of this lab exercise, you’ll be able to

• Perform a live capture of network traffic by sniffing and filtering
with Wireshark


(Old Labs below)
Lab Exercise 6.04: Packet Sniffing

Lab Exercise 7.01: tracert

Lab Exercise 7.02: NAT and Port Forwarding

Lab Exercise 8.03: HTTP

Lab Exercise 8.04: FTP

Lab Exercise 8.05: The TCP Three-Way Handshake and Beyond

Lab Exercise 9.01: DNS Queries, DNS Responses, and DNS Resolver Cache

Lab Exercise 9.02: nslookup

Lab Exercise 9.03: DNS Client and DNS Server

Lab Exercise 10.02: Secure Ports, OpenSSH, and TLS

Lab Exercise 11.04: SPAN

Lab Exercise 12.03: IPv6 Configuration and Communication

Lab Exercise 12.04: IPv6 Neighbor Discovery Protocol (RS, RA)

Lab Exercise 12.05: IPv6 Neighbor Discovery Protocol (NS, NA)

Continue Lab Exercise 13.00

Lab Exercise 13.01: VPN

Lab Exercise 13.02: Remote Desktop

Lab Exercise 15.03: Traffic Between the Host System and the VM

Lab Exercise 15.04: Traffic from the VM to the Internet