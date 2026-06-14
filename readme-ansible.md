# Resources to learn
- Red Hat RHCE 8 (EX294) Cert Guide
- Kraker's RHCE guide
https://kraker.codeberg.page/rhce/

# Chapter 1. Understanding Configuration Management

## Other Automation Solutions
Like Ansible, Puppet is one of the most important
automation solutions. There are a few reasons why
Ansible is taking over market share from Puppet
though. One of the reasons is YAML. Ansible
configurations are written in YAML, which is an easy-to-
use and easy-to-understand language. Puppet uses its
own language, which is just not as easy. Another major
difference is that Ansible uses a push approach, where
configurations are sent from the controller node to the
managed nodes. Puppet uses a pull approach as its main
strategy, where managed nodes use an agent to connect
to the Puppet master to fetch their desired state.

Chef is built as a client/server solution, where the server
parts run on the master machine and the client parts are
implemented as an agent on the managed machines.
Chef provides its configuration in Ruby DSL, whereas
Ansible uses playbooks written in YAML. As a result,
Ansible is easier to learn because YAML is a much more
accessible data format.

SaltStack is another important alternative to Ansible.
The main difference between Ansible and SaltStack is
the performance. SaltStack uses the ZeroMQ message
queue to realize communication between the SaltStack
minions and the master, and that seems to be faster.
SaltStack uses configurations that are written in Jinja2
and use an agent, which makes the learning curve to get
started with SaltStack also more complex.

## UNDERSTANDING ANSIBLE ESSENTIAL COMPONENTS

### (Skip) Ansible Is Python

### Ansible Architecture
There are two main node roles in Ansible. The controller
node is the node that runs the Ansible software and
from which the operator issues Ansible commands. The
controller node can be a server running Linux, an
operator laptop, or a system running Ansible Tower. The
only requirement is that the controller node needs to be
Linux.

From the controller node, the managed nodes are
addressed. On the controller node, an inventory is
maintained to know which managed nodes are available.
Ansible doesn’t require the use of any agents. That
means it can reach out to managed nodes without a
need to install anything. To do so, Ansible uses native
remote access solutions that are provided by the
managed node. On Linux, remote access is realized by
using SSH; on Windows, it is realized by using Windows
Remote Management (WinRM); and on network
devices, it can be provided by using SSH or API access.

To configure the managed nodes, Ansible uses
playbooks. A playbook is written in YAML and contains
one or more plays. Each play consists of one or more
tasks that are executed on the managed nodes.

To implement the tasks, Ansible uses modules. Modules
are the pieces of code that do the actual work on the
managed nodes, and many modules are available—more
than 3,000 already, and the number is increasing.

Ansible also provides plug-ins. Ansible plug-ins are used
to extend Ansible functionality with additional features.
Ansible playbooks should be developed to be
idempotent. That means a playbook will always produce
the same results, even if it is started multiple times on
the same node. As a part of the idempotency, playbooks
should also be self-containing and not depend on any
other playbooks to be successful.

### Understanding Ansible Tower
Ansible can be used in two different ways: Ansible
Engine or Ansible Tower. Ansible Engine is the
command-line version of Ansible, where modules and
plug-ins are used to offer Ansible functionality. Ansible
Engine is the solution of choice for people who like to
work from the command line in a medium- to mid-sized
environment.

Apart from Ansible Engine, there is Ansible Tower,
which is based on the AWX open-source solution. It
provides a web-based interface to manage Ansible.
Ansible Tower adds different features to Ansible Engine,
such as

• Web management interface
• Role-based access control
• Job scheduling
• Enhanced security
• Centralized loggin

Because the RHCE EX294 exam is about Ansible
Engine, you won’t find much information about Ansible
Tower in this book.

### (Return after learning more) Understanding the Ansible Way
The core of Ansible is configuration management. The
Ansible modules and plug-ins cover a wide range of
functions, which means that Ansible can be used for
configuration management and beyond. Here are some
common use cases.

#### Using Ansible for Configuration Management
Many people know Ansible only as a configuration
management solution, and there’s a reason for that.
Ansible started as a solution for configuration
management, and that is what it still is used for in most
cases. In configuration management, Ansible is used to
manage configuration files, install software, create
users, and perform similar tasks to guarantee that the
managed systems all are in the desired state.

#### Using Ansible for Provisioning
Another common scenario for use of Ansible is for
deploying and installing systems (provisioning).
Provisioning is particularly common in virtual and cloud
environments, where in the end a new machine is just a
configuration file that needs to be pushed to the
managed machine and started from there. Ansible does
not offer the functionality to PXE-boot and kickstart a
bare-metal server but is used in combination with
solutions that can take care of that as well. While
exploring the different modules that are available, you’ll
notice that a wide range of modules is provided to work
with Ansible in different cloud environments.

#### Using Ansible for Continuous Delivery
*** I still don't fully understand CI / CD, since it's mostly automation ***
 
Continuous integration/continuous delivery (CI/CD)
makes sure that source code can easily be developed and
updated, and the results are easily provisioned as a new
version of an application. Ansible cannot take care of the
entire CI/CD procedure itself, but Ansible playbooks can
play an important role in the CD part of the CI/CD
pipeline.

# Chapter 2. Installing Ansible

