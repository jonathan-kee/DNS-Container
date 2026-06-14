# Easier Installation
https://registry.terraform.io/providers/bmatcuk/vagrant/latest/docs/resources/vm
^
Easiest Way to port over to terraform

# Installation for MacOS (Too complicated than my vagrantfile)
brew install qemu
which qemu-system-aarch64

## Add HashiCorp tap and install native Terraform
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

## Install libvirt (provides the local C bindings/libraries the provider compiles against)
brew install libvirt

## Install the provider itself directly via Homebrew (compiled natively for Apple Silicon)
brew install terraform-provider-libvirt

## (Note: Check the version of the provider Homebrew installed by running brew info terraform-provider-libvirt and adjust the version 0.9.8 in the path above if necessary).
brew info terraform-provider-libvirt

## Configure Terraform to find the Local Provider
mkdir -p ~/.terraform.d/plugins/registry.terraform.io/dmacvicar/libvirt/0.9.8/darwin_arm64

## Create a symlink from Homebrew's native build into your local Terraform plugin directory:
ln -s $(which terraform-provider-libvirt) ~/.terraform.d/plugins/registry.terraform.io/dmacvicar/libvirt/0.9.8/darwin_arm64/terraform-provider-libvirt_v0.9.8

## Running Libvirt Locally on your Mac
brew services start libvirt
brew services list

## Adjust your main.tf to target your local user session and enforce the Apple Hypervisor framework (hvf) or software emulation (qemu):

terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.9.8" # Match your local symlinked version
    }
  }
}

// Connect to your local macOS user session daemon
provider "libvirt" {
  uri = "qemu:///session"
}

// 1. Define a Local Storage Pool for your images
resource "libvirt_pool" "local_pool" {
  name = "local-storage"
  type = "dir"
  path = "${path.module}/kvm-storage"
}

// 2. Fetch/Prepare an ARM64 Base Image (Crucial: Must be ARM64/aarch64!)
resource "libvirt_volume" "ubuntu_arm64" {
  name   = "ubuntu-22.04-arm64.qcow2"
  pool   = libvirt_pool.local_pool.source
  // Example URL for Ubuntu ARM64 Cloud Image
  source = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-arm64.img"
  format = "qcow2"
}

// 3. Define the Local Apple Silicon VM
resource "libvirt_domain" "mac_vm" {
  name   = "macos-local-ubuntu"
  memory = "2048"
  vcpu   = 2

  // --- CRITICAL APPLE SILICON BLOCKS ---
  arch        = "aarch64"
  type        = "qemu"
  domain_type = "hvf" # Tells QEMU to use Apple Hypervisor.framework

  // Explicitly point to the Homebrew QEMU ARM64 system binary
  // Note: Adjust path if you installed homebrew in a non-standard location
  emulator = "/opt/homebrew/bin/qemu-system-aarch64" 
  
  // Ensure the machine type matches ARM virtual environments
  machine = "virt"
  // -------------------------------------

  storage {
    volume_id = libvirt_volume.ubuntu_arm64.id
  }

  graphics {
    type        = "vnc"
    listen_type = "address"
    autoport    = true
  }
}

## Initialize and Test
// Ensure directory for storage pool exists locally
mkdir -p kvm-storage

// Initialize and pull the local provider
terraform init

// Validate configuration
terraform validate

// Spin up the local VM
terraform apply

# Resources to learn
Install Qemu on MacOS:
https://www.qemu.org/download/#macos

Install Libvirt for MacOS:
https://libvirt.org/macos.html

Libvirt has services involved when installed:
https://libvirt.org/daemons.html

Install docker-virt-manager
https://github.com/m-bers/docker-virt-manager

Terraform provider to provision infrastructure with Linux's KVM using libvirt:
https://github.com/dmacvicar/terraform-provider-libvirt
^
Try first, maybe no need KVM

Try out qemux/qemu-arm:
docker run -it --rm --name qemu -e "BOOT=ubuntu" -p 8006:8006 --device=/dev/kvm --device=/dev/net/tun --cap-add NET_ADMIN -v "${PWD:-.}/qemu:/storage" --stop-timeout 120 docker.io/qemux/qemu-arm

docker run -it --rm --name qemu \
  -e "BOOT=ubuntu" \
  -p 8006:8006 \
  -v "${PWD:-.}/qemu:/storage" \
  --stop-timeout 120 \
  docker.io/qemux/qemu-arm

Below seems to work:
docker run -it --rm --name qemu \
  -e "BOOT=ubuntu" \
  -e "KVM=N" \
  -p 8006:8006 \
  -v "${PWD:-.}/qemu:/storage" \
  --stop-timeout 120 \
  docker.io/qemux/qemu-arm

# KVM, QEMU, Libvirt, virt-manager, how do these all relate?
Question: KVM, QEMU, Libvirt, virt-manager, how do these all relate?

TLDR:
kvm -> qemu -> libvirt -> virt-manager
                       -> terraform provider

Link to Reddit post:
https://www.reddit.com/r/linuxquestions/comments/9duxao/kvm_qemu_libvirt_virtmanager_how_do_these_all/

Answer:
Basically, it's a stack.

From the bottom to top:
1) KVM is the Kernel Module that accelerates x86/amd64 virtualization, but not other machine types. It's basically a shortcut so that guests can use the hosts CPU at almost hardware speed.
^
KVM is a type 1 hypervisor (Same as Proxmox)

2) QEMU is the virtualizer software that actually "runs" the virtual machines. It can run without KVM, but it's much much slower because then QEMU has to really "simulate" the guest CPU. You can run it directly without the rest, but the command line options are a bit... daunting.
^
QEMU is a type 2 hypervisor (Same as Vagrant).

3) libvirt is "glue" layer/library that arranges and manages QEMU sessions, its disks, the networks, and so on. It can also use other virtualizers than QEMU, like Xen for example. It has an API, a scripting interface, a command line interface, a network connection interface, and...

4) virt-manager is the graphical user interface for libvirt that allows you to do all these virtualization things without ever touching a command line.

# EXTRA
https://medium.com/@mohrezfadaei/vagrant-and-virtualbox-are-no-longer-enough-why-kvm-and-terraform-are-the-future-of-devops-24f978c9ca2c
^
TLDR of KVM & QEMU:
KVM is a type 1 hypervisor (Same as Proxmox). QEMU is a type 2 hypervisor (Same as Vagrant). They are different products.

https://medium.com/@armantaherighaletaki/setting-up-qemu-kvm-virtual-machines-with-libvirt-using-terraform-b3c040203f9d
^
Another one

https://github.com/cirruslabs/linux-image-templates
^
Tart is a virtualization toolset to build, run and manage macOS and Linux virtual machines on Apple Silicon.

https://registry.terraform.io/providers/bmatcuk/vagrant/latest/docs/resources/vm
^
Easiest Way to port over to terraform

Try the below tommorow:
https://libvirt.org/macos.html
https://github.com/dmacvicar/terraform-provider-libvirt
https://gist.github.com/gwarf/3d63b24ff86a5311da87baa7ccbb7882
https://medium.com/@aryangodara_19887/qemu-virt-manager-and-libvirt-on-macos-with-apple-silicon-m2-dc677e6b8559
^
Related to Qemu:
https://www.qemu.org/download/#macos

My understanding so far
kvm -> qemu -> libvirt -> virt-manager
                       -> terraform provider


Try libvirt manager container:
https://github.com/m-bers/docker-virt-manager

Below three links are related:
https://portal.cloud.hashicorp.com/vagrant/discover?architectures=arm64&providers=libvirt
Good Explanation on libvirt tooling
https://andreas-mausch.de/blog/2022-11-28-virtual-machines-virtualbox-libvirt-qemu-vagrant/
Terraform - KVM - Multi VM Build - Ubuntu Server
https://www.youtube.com/watch?v=Lt8cHwy-jEM