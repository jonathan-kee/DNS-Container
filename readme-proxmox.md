# Pre-requisite to Proxmox
1.3 Summarize general OS installation considerations and upgrade methods.
https://github.com/rjmsecurity/ontologia/blob/main/CompTIA%20A+%201102.md#13-summarize-general-os-installation-considerations-and-upgrade-methods

Boot methods:
https://github.com/rjmsecurity/ontologia/blob/main/Concepts/Systems/Boot%20methods.md
^
I think using USB flash drive or external eSATA drive is recommended

Types of installations:
https://github.com/rjmsecurity/ontologia/blob/main/Concepts/Systems/Types%20of%20installations.md
^
I am guessing first time installation falls under "clean install"

Partitioning:
https://github.com/rjmsecurity/ontologia/blob/main/Concepts/Systems/Partitioning.md
^
Not sure which one, watch the 7 hour video to know

File system types/formatting:
https://github.com/rjmsecurity/ontologia/blob/main/Concepts/Systems/Formatting.md
^
I think this is hardware related

You can try out the below vagrant box:
​​https://portal.cloud.hashicorp.com/vagrant/discover/gyptazy/proxmox8.1-arm64
^
This does not work

cd proxmox
vagrant up --provider vmware_desktop
^
Thos does not work

7 hour video on Proxmox:
https://www.youtube.com/watch?v=Iz76KqzloJY
^
Proxmox is type 1 hypervixor
^
Compared to Virtualbox, which is type 2 hypervisor

Virtual Machines vs LXC vs Docker: What’s the Real Difference?
https://www.youtube.com/watch?v=RB4ZEZ3I3tA

Virtual Machines vs LXC System Containers vs Docker forum post
https://forums.lawrencesystems.com/t/virtual-machines-vs-lxc-system-containers-vs-docker/26497
^
Now docker can be inside Host, VM, LXC