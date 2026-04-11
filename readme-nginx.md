# Keywords need to be familiar
- load balancer
- reverse proxy
- forward proxy
- caching layer

## Comptia Network+ Proxy Server Explanation
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