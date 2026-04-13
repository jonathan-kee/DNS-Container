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
- proxy targets

KodeKloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Intermediate-Config/Virtual-Servers-Multiple-Sites/page

Kodekloud notes link:
https://notes.kodekloud.com/docs/Nginx-For-Beginners/Intermediate-Config/Virtual-Servers-Multiple-Sites/page#how-nginx-virtual-servers-work

- Virtual servers (also known as server blocks or virtual hosts)
- Host header 

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