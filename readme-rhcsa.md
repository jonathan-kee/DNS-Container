# Kraker Notes
## Module 08: Networking
https://alexkraker.com/rhcsa/rhcsa_synthesis/08_networking/#key-terminology
^
For Key Terminology section, I am not familiar with the below:
- Connection: NetworkManager configuration profile applied to interface
- Profile: Persistent network configuration including IP, DNS, gateway
- MTU: Maximum Transmission Unit - largest packet size for interface

Question: What is the difference between Physical or virtual network device?

https://alexkraker.com/rhcsa/rhcsa_synthesis/08_networking/#decision-tree-network-configuration-strategy
^
Question: Multiple IPs can be assigned because a computer has multiple interfaces
Question: What is VLANS?
Question: What is Bonding?

https://alexkraker.com/rhcsa/rhcsa_synthesis/08_networking/#standard-procedure-network-troubleshooting
^
I think Wireshark is a great way to understand OSI model like 
- Layer 3 - IP connectivity
- Layer 7 - DNS resolution 

https://alexkraker.com/rhcsa/rhcsa_synthesis/08_networking/#lab-61-basic-network-configuration-asghar-ghori-style
^
Question: For 2. Create static IP configuration, how does it look like in the GUI?

## Module 10: Firewall
https://alexkraker.com/rhcsa/rhcsa_synthesis/10_firewall/#key-terminology
^
For Key Terminology section, I am not familiar with all of them:
- Zone: Security context with specific rules applied to network interfaces
- Service: Predefined firewall rule for common applications (http, ssh, etc.)
- Port: Specific TCP/UDP port number that can be opened
- Rich rule: Complex firewall rule with advanced conditions and actions
- Runtime configuration: Currently active rules (lost on restart)
- Permanent configuration: Persistent rules saved to configuration files
- Source: IP address or network range for rule targeting
- Target: Default action for traffic not matching any rules in a zone

# Sander Red Hat RHCSA 9 (EX200) Book
## Part IV Managing Network Services
### Chapter 23, Configuring a Firewall
*** Docker uses ip tables by default, but can also use nftables ***
^
Link to Docker documentation:
https://docs.docker.com/engine/network/packet-filtering-firewalls/#firewall-backend


