# Keywords need to be familiar

KodeKloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Introduction/Nginx-Architecture/page#event-driven-architecture-overview
- Master and Worker Processes

KodeKloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Introduction/Nginx-Use-Cases/page
- Load balancer
- Reverse proxy
- Forward proxy
- Caching layer
- Offloading SSL/TLS and request routing
- Controlling outbound traffic and anonymizing clients

KodeKloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Install-Config/Nginx-Overview/page
- virtual hosts
- Symbolic links
- MIME type definitions
- PID file location

(Continue) KodeKloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Install-Config/Install-Config/page

KodeKloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Install-Config/Demo-Nginx-Install-Config/page#5-1-common-configuration-directories

- Core Nginx configuration
- Independent configuration fragments
- Virtual host definitions (disabled by default)
- Symlinks to enabled virtual hosts

(Good resource to follow for first website) KodeKloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Install-Config/Demo-First-Website-with-Nginx/page

KodeKloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Install-Config/Firewall-Ports/page
^
Does not deep into how Linux Distro firewall works

KodeKloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Install-Config/Demo-Firewall-Ports-Install-Config/page

- VPN

KodeKloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Install-Config/Summary/page
^
I think Ansible is the one configuring the firewalls

KodeKloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Intermediate-Config/Intermediate-Config-introduction/page

- Upstream
^
Can't find the explanation in Comptia Network+

- proxy targets

KodeKloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Intermediate-Config/Virtual-Servers-Multiple-Sites/page

Kodekloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Intermediate-Config/Virtual-Servers-Multiple-Sites/page#how-nginx-virtual-servers-work

- Virtual servers (also known as server blocks or virtual hosts)
- Host header 

(Good resource to follow for multiple website on a single nginx server) Kodekloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Intermediate-Config/Virtual-Servers-Multiple-Sites/page#managing-multiple-server-blocks

(Good resource to follow for multiple website on a single nginx server part 2) Kodekloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Intermediate-Config/Demo-Configure-Multiple-Sites/page

(Not enough experience / foundation to understand why redirect) Kodekloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Intermediate-Config/URL-Redirect-Rewrite/page#why-redirect-vs-rewrite

Kodekloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Intermediate-Config/Load-Balancer/page

- upstream pools
- single point of failure
- health checks
- proxy_pass
- Various Algorithms (Round Robin, Weighted Round Robin, IP Hash, Least Connections, Least Time*)

Kodekloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Intermediate-Config/Reverse-Proxy/page

- Hiding backend server identities
- SSL/TLS offloading
- The reverse proxy exposes only itself to the Internet
- Backend servers remain isolated on private networks
- ssl_certificate
- ssl_certificate_key
- ssl_protocols
- proxy server local storage

Kodekloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Intermediate-Config/Summary/page

- Server weighting
- Session stickiness
- session affinity
- NAT/proxying
- IP-based sticky sessions
- robust session persistence
- prefer shared session stores (for example, Redis)
- application-level affinity techniques
- cache invalidation 

(Not enough experience / foundation to understand why redirect) Kodekloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Security/Security-Introduction/page

- Self-Signed Certificates
- Automated certificates

*** I think Comptia Security+ Covers the Security section ***

## Comptia Network+ Proxy Server Explanation (Reverse proxy, Foward proxy, Caching layer)
A proxy server sits in between clients and external servers, essentially pocketing the requests
from the clients for server resources and making those requests itself. The client comput-
ers never touch the outside servers and thus stay protected from any unwanted activity.
A proxy server usually does something to those requests as well. Let’s see how proxy servers
work using HTTP, one of the oldest uses of proxy servers.

Since proxy serving works by redirecting client requests to a proxy server, you first
must tell the Web client not to use the usual DNS resolution to determine the Web server
and instead to use a proxy. Every Web client comes with a program that enables you to set
the IP address of the proxy server, as shown in the example in Figure 11-18.

*** Figure 11-18 Setting a proxy server in Mozilla Firefox ***

Once the proxy server is configured, HTTP requests move from the client directly
to the proxy server. Built into every HTTP request is the URL of the target Web server,
so the Web proxy knows where to get the requested data once it gets the request. In the
simplest format, the proxy server simply forwards the requests using its own IP address
and then forwards the returning packets to the client (Figure 11-19).

*** Figure 11-19 Web proxy at work ***

This simple version of using a proxy server prevents the Web server from know-
ing where the client is located—a handy trick for those who wish to keep people from
knowing where they are coming from, assuming you can find a public proxy server that
accepts your HTTP requests (there are plenty!). There are many other good reasons to
use a proxy server. One big benefit is caching. A proxy server keeps a copy of the served
resource, giving clients a much faster response.

A forward proxy server acts on behalf of clients, getting information from various
sources and handing that info to the clients. The sources (servers) don’t know about the
clients, only the proxy server.

NOTE If a proxy server caches a Web page, how does it know if the cache
accurately reflects the real page? What if the real Web page was updated?
In this case, a good proxy server uses querying tools to check the real Web
page to update the cache. The benefit of a caching proxy is that content can
be retrieved without contacting sites over WAN links.

A reverse proxy server, in contrast, acts on behalf of its servers. Clients contact the
reverse proxy server, which gathers information from its associated server(s) and hands
that information to the clients. The clients don’t know about the servers behind the
scenes. The reverse proxy server is the only machine with which they interact.

A proxy server might inspect the contents of the resource, looking for inappropriate
content, viruses/malware, or just about anything else the creators of the proxy might
desire it to identify.

HTTP proxy servers are the most common type of proxy server, but any TCP applica-
tion can take advantage of proxy servers. Numerous proxy serving programs are available,
such as Squid, shown in Figure 11-20. Proxy serving takes some substantial processing,
so many vendors sell proxy servers in an integrated hardware solution, such as Broad-
com’s Symantec Secure Web Gateway Appliance.

*** Figure 11-20 Squid Proxy Server software ***

## Comptia Network+ Load Balancing Explanation 
(Switch Features, Load Balancing)
Popular Internet servers are exactly that—popular. So popular that a single system cannot
possibly support the thousands, if not millions, of requests per day that bombard them.
But from what you’ve learned thus far about servers, you know that a single server has
a single IP address. Put this to the test. Go to a command prompt and type ping www
.google.com and press enter.

C:\>ping www.google.com
Pinging www.l.google.com [74.125.95.147] with 32 bytes of data:
Reply from 74.125.95.147: bytes=32 time=71ms TTL=242
Reply from 74.125.95.147: bytes=32 time=71ms TTL=242
Reply from 74.125.95.147: bytes=32 time=70ms TTL=242
Reply from 74.125.95.147: bytes=32 time=70ms TTL=242

A seriously epic site like google.com will handle trillions of search requests per year.
Let’s throw hypothetical math into the mix. Imagine 2 trillion requests; the average would
be well over 5 billion search requests a day and 60,000 per second. Each of those 60,000
requests might require the Web server to deliver thousands of HTTP segments. A single,
powerful, dedicated Web server simply can’t handle that load. A busy Web site often needs
more than one Web server to handle all the requests. Let’s say a Web site needs three serv-
ers to handle the traffic. How does that one Web site, using three different servers, use a
single IP address? The answer is found in something called load balancing.

NOTE Coming to a consensus on statistics like the number of requests/day
or how many requests a single server can handle is difficult. Just concentrate
on the concept. If some nerdy type says your numbers are way off, nicely
agree and walk away. Just don’t invite them to any parties.

Load balancing means making a bunch of servers look like a single server, creating a
server cluster. Not only do you need to make them look like one server, you need to make
sure that requests to these servers are distributed evenly so no one server is bogged down
while another is idle. There are a few ways to do this, as you are about to see. Be warned,
not all of these methods require an advanced network device called a load balancer, but
it’s common to use one. Employing a device designed to do one thing really well is always
much faster than using a general-purpose computer and slapping on software.

*** Skipped DNS Load Balancing ***

(Switch Features, Load Balancing, Content Switch)
Many multilayer switches handle load balancing by functioning at multiple layers. An
alternative is a content switch. Content switches always work at Layer 7 (Application layer).
Content switches designed to work with Web servers, for example, can read incoming
HTTP and HTTPS requests. With this feature, you can perform very advanced actions,
such as handling TLS certificates and cookies, on the content switch, removing the work-
load from the Web servers. Not only can these devices load balance in the ways previously
described, but their HTTP savvy can actually pass a cookie to HTTP requesters—Web
browsers—so the next time that client returns, it is sent to the same server.

## Comptia Network+ Load Balancing Explanation (Data Centers)
As a concept, load balancing means to share among two or more systems the effort to
enable some process to work. You saw this concept way back in Chapter 11 in the con-
text of using multiple servers as a server cluster that manifests as a single entity. Special-
purpose load balancers help apportion the work among the various servers. You’ve seen
the concept used in spine-and-leaf data centers earlier that rely on protocols like ECPM to
balance the work among the various switches so that no single connection gets swamped.
Load balancing in its many forms is one pillar of high availability.

Clustering, in the traditional sense, means to have multiple pieces of equipment, such
as servers, connected in a manner that appears to the user and the network as one logical
device, providing data and services to the organization. Clusters usually share high-speed
networking connections as well as data stores and applications and are configured to
provide redundancy if a single member of the cluster fails.

NOTE Clustering solutions are commonly active-active examples of high
availability in that all members of the cluster are active at the same time.

## Comptia Network+ SSL/TLS Explanation (Chapter 8: TCP/IP Applications)
Any nosy person who can plug into a network can see and read the HTTP packets mov-
ing between a Web server and a Web client. Less than nice people can easily create a
fake Web site to trick people into thinking it’s a legitimate Web site and then steal their
usernames and passwords. For these and other reasons, the Internet has moved away
from HTTP.

For an Internet application to be secure, it must have the following:
• Authentication Usernames and passwords
• Encryption Stirring up the data so others can’t read it
• Nonrepudiation Source is not able to deny a sent message

All of Chapter 10 is dedicated to these concepts, but the Web side of things requires
mention here. Almost every Web site today uses the secure version of HTTP, called
Hypertext Transfer Protocol Secure (HTTPS), to enable connections between clients and
servers that hackers can’t break. HTTPS uses Transport Layer Security (TLS), the latest
version of Secure Sockets Layer (SSL), although techs use the terms interchangeably. SSL/
TLS uses encryption to set up a secure private connection.

EXAM TIP The CompTIA Network+ exam objectives use Hypertext Transfer
Protocol Secure for HTTPS, though you’ll hear the older terms—HTTP over
SSL and HTTP over TLS—used by many techs.

HTTPS uses TCP port 443. You can tell a Web page is using HTTPS by the URL
(starts with https://) or a small lock icon in the address bar of the browser. Figure 8-21
shows a typical secure Web page.

EXAM TIP HTTP enables you to access the Web, but HTTPS gets you there
securely. HTTPS uses TLS to provide the security. The exam objectives list
HTTPS twice. The first is Hypertext Transfer Protocol Secure (HTTPS) [Secure
Sockets Layer (SSL)]. The second time is HTTPS [Transport Layer Security (TLS)]
to reinforce that modern HTTPS uses TLS rather than SSL.

## Comptia Network+ SSL/TLS Explanation (Chapter 10: Securing TCP/IP)
SSL requires a server with a certificate. When a client requests
access to an SSL-secured server, the server sends to the client a copy of the certificate
(Figure 10-30). The SSL client checks this certificate (all Web browsers come with an
exhaustive list of CA root certificates preloaded), and if the certificate checks out, the
server is authenticated and the client negotiates a symmetric-key cipher for use in the
session. The session is now in a very secure encrypted tunnel between the SSL server and
the SSL client

*** Figure 10-30 Fetching the server’s certificate ***

The Transport Layer Security (TLS) protocol was designed as an upgrade to SSL. TLS is
very similar to SSL, working in almost the same way. TLS is more robust and flexible and
works with just about any TCP application. SSL is limited to HTTP, FTP, SMTP, and a
few older TCP applications. TLS has no such restrictions and is used in securing Voice
over IP (VoIP) and virtual private networks (VPNs), but it is still most heavily used in
securing Web pages. Every Web browser today uses TLS for HTTPS-secured Web sites,
and EAP-TLS (discussed in Chapter 14) is common for more-secure wireless networks.

NOTE SSL/TLS also supports mutual authentication, but this is relatively rare.

## Comptia Network+ SSL/TLS Explanation (Chapter 13: WAN Connectivity, SSL (Really TLS) VPNs)
Cisco makes VPN hardware that enables SSL VPNs. These types of VPN offer an advan-
tage over Data Link– or Network-based VPNs because they don’t require any special
client software. Clientless VPN clients connect to the VPN server using a standard Web
browser, with the traffic secured using Transport Layer Security (TLS), requiring no spe-
cific client-based software. (TLS replaced Secure Sockets Layer, or SSL, many years ago,
but the SSL VPN moniker stuck.) The two most common types of SSL VPNs are SSL
portal VPNs and SSL tunnel VPNs.

NOTE Many VPN technologies use the terms client and server to denote the
functions of the devices that make the connection. You’ll also see the terms
host and gateway to refer to the connections, such as a host-to-gateway
tunnel.

With SSL portal VPNs, a client accesses the VPN and is presented with a secure
Web page. The client gains access to anything linked on that page, be it e-mail, data,
links to other pages, and so on.

With tunnel VPNs, in contrast, the client Web browser runs some kind of active
control, such as Java, and gains much greater access to the VPN-connected network. SSL
tunnel VPNs create a more typical host-to-site connection than SSL portal VPNs, but
the user must have sufficient permissions to run the active browser controls.

## Comptia Network+ SSL/TLS Explanation (Chapter 21: Network Troubleshooting)
TLS/SSL certificates have expiration dates and companies need to maintain them prop-
erly. If you get complaints from clients that the company Web site is giving their browsers
untrusted TLS/SSL certificate errors, chances are that the certificate has expired. The fix
for that is pretty simple—update the certificate.

## Comptia Network+ outbound traffic Explanation
outbound traffic Describes the direction of a flow of packets relative to some point
of reference. Relative to the entire network, packets leaving the network from within it.

## Comptia Network+ Virtual Private Networks Explanation (Chapter 13: WAN Connectivity)
Remote connections have been around for a long time, even before the Internet existed.
The biggest drawback to remote connections was the cost to connect. If you were on one
side of the continent and had to connect to your LAN on the other side of the continent,
the only connection option was a telephone. Or, if you needed to connect two LANs
across the continent, you ended up paying outrageous monthly charges for a private con-
nection. The introduction of the Internet gave people wishing to connect to their home
or work networks a very inexpensive connection option, but there was one problem—the
whole Internet was (and is) open to the public. People wanted to stop using dial-up and
expensive private connections and use the Internet instead, but they wanted to be able
to do it securely.

If you read the previous chapter, you might think you could use some of the tools for
securing TCP/IP to help, and you would be correct. Several standards use encrypted tun-
nels between a computer or a remote network and a private network through the Internet
(Figure 13-20), resulting in what is called a virtual private network (VPN).

*** Figure 13-20 VPN connecting computers across the United States ***

An encrypted tunnel requires endpoints—the ends of the tunnel where the data is
encrypted and decrypted. In the tunnels you’ve seen thus far, the client for the applica-
tion sits on one end and the server sits on the other. VPNs do the same thing. Either
some software running on a computer or, in some cases, a dedicated box must act as an
endpoint for a VPN (Figure 13-21).

*** Figure 13-21 Typical tunnel ***

The key with the VPN is that the computers should be on the same network—and
that means they must all have the same network ID. You would want the laptop that
you use in the Denver airport lounge, for example, to have the same network ID as the
computers in the LAN back at the office. But there’s no simple way to do this. If it’s
a single client trying to access a network, that client is going to take on the IP address
from its local DHCP server. In the case of your laptop in the airport, your network ID
and IP address come from the DHCP server in the airport, not the DHCP server back
at the office.

To make the VPN work, you need VPN client software installed on your local
machine—the laptop at the Denver airport—and VPN server software or hardware
at your office. You connect your laptop first to the Internet using the airport wireless
network; it’s just a normal Internet connection. Second, the VPN client software creates
a virtual NIC on your laptop (endpoint 1), makes a connection with the VPN server
at the office (endpoint 2), and then, in essence, creates a virtual direct cable from the
virtual NIC to the office (Figure 13-22). That “virtual cable” is called a VPN tunnel.
The laptop now has two IPv4 addresses. One is local from the airport DHCP server.
The other is “local,” but works with the office network. That second IP address goes
with the virtual NIC.

*** Figure 13-22 Endpoints must have their own IP addresses.

Clever network engineers have come up with many ways to make this work, and
those implementations function at different layers of the OSI model. PPTP and L2TP,
for example, work at the Data Link layer. Many VPNs use IPsec at the Network layer to
handle encryption needs. TLS VPNs don’t really fit into the OSI model well at all, with
some features in the Session layer and others in the Presentation layer.

## Comptia Network+ Virtual Private Networks Explanation (Chapter 15: Virtualization and Cloud Computing)
The most convenient way to connect a network to the public cloud is through a VPN.
As discussed back in Chapter 13, a VPN creates an encrypted tunnel between two net-
works over another, less-secure network. A site-to-site VPN can establish a permanent
tunnel (often using IPsec) between a local network and a virtual network in the cloud.

VPN tunnels are relativity simple to set up because they use off-the-shelf technology
like IPsec. This makes them easy to integrate with existing site-to-site WAN infrastruc-
ture or even an SD-WAN service (like you saw in Chapter 13).

There are many reasons you might want or need to interconnect these networks. The
reasons all basically boil down to making it easier for a device on one side to access a
resource on the other. To work on this chapter from the Amazon WorkSpace I showed
you in the DaaS section earlier, for example, WorkSpaces needed access to my file server.
Figure 15-27 shows the VPN tunnel set up between my network’s router and the AWS
Virtual Private Cloud network to which my virtual desktop is attached. Once I have the
tunnel set up and the routes propagate, I can copy down my working files as shown in
Figure 15-28.

*** Figure 15-27 VPN activity on my network’s router and its BGP routing table ***

*** Figure 15-28 Transferring files from my on-premises file server to my virtual desktop ***

### Private Direct Connection
VPNs are easy to set up, but big-time organizations often need big-time pipes. Provid-
ers such as AWS and Azure offer private direct connections—private direct links between
your network and the cloud provider’s—to meet this need. These connections take one
of two forms: a physical port on the cloud provider’s switch, which enables you to run
fiber between your equipment and the cloud provider’s, or a leased line that you contract
through a third party. The main thing to keep in mind is that the traffic for a private
direct connection never goes over the public Internet. It’s a private line between your data
center and your cloud provider.

EXAM TIP You might see a question on the CompTIA Network+ exam that
calls on you to identify a private-direct connection to cloud provider. That’s a
specific high-end (and expensive) data connection, as discussed here.

# Extra
Continue where I left off:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Intermediate-Config/Demo-Configure-URL-Redirect/page#2-review-existing-nginx-configuration
^
Other People Project include Nginx with React:
https://github.com/Abhiram-Rakesh/Three-Tier-EKS-Terraform
^
I am confuse if alot of these nginx terms are available in Comptia Network+

More learning resource:
https://community.nginx.org/t/nginx-learning-resources/8462

Important nginx feature to track who is accessing the nginx:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Performance/Monitoring-Troubleshooting/page