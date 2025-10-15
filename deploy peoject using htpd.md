egister this system with Red Hat Insights: rhc connect

Example:
# rhc connect --activation-key <key> --organization <org>

The rhc client and Red Hat Insights will enable analytics and additional
management capabilities on your system.
View your connected systems at https://console.redhat.com/insights

You can learn more about how to register your system 
using rhc at https://red.ht/registration
Last login: Wed Oct 15 12:31:40 2025 from 47.15.105.236
[ec2-user@ip-172-31-38-22 ~]$ pwd
/home/ec2-user
[ec2-user@ip-172-31-38-22 ~]$ ls
[ec2-user@ip-172-31-38-22 ~]$ cd ..
[ec2-user@ip-172-31-38-22 home]$ pwd
/home
[ec2-user@ip-172-31-38-22 home]$ ls
ec2-user
[ec2-user@ip-172-31-38-22 home]$ cd .
[ec2-user@ip-172-31-38-22 home]$ ls
ec2-user
[ec2-user@ip-172-31-38-22 home]$ ec ..
-bash: ec: command not found
[ec2-user@ip-172-31-38-22 home]$ ls
ec2-user
[ec2-user@ip-172-31-38-22 home]$ cd root
-bash: cd: root: No such file or directory
[ec2-user@ip-172-31-38-22 home]$ cd ec2-user
[ec2-user@ip-172-31-38-22 ~]$ ls
[ec2-user@ip-172-31-38-22 ~]$ ls
[ec2-user@ip-172-31-38-22 ~]$ pwd
/home/ec2-user
[ec2-user@ip-172-31-38-22 ~]$ sudo upda=^C
[ec2-user@ip-172-31-38-22 ~]$ yum update -y
Not root, Subscription Management repositories not updated
Error: This command has to be run with superuser privileges (under the root user on most systems).
[ec2-user@ip-172-31-38-22 ~]$ sudo yum update
Updating Subscription Management repositories.
Unable to read consumer identity

This system is not registered with an entitlement server. You can use "rhc" or "subscription-manager" to register.

Red Hat Enterprise Linux 10 for x86_64 - AppStr  23 MB/s | 3.2 MB     00:00    
Red Hat Enterprise Linux 10 for x86_64 - BaseOS  64 MB/s |  28 MB     00:00    
Red Hat Enterprise Linux 10 Client Configuratio  31 kB/s | 2.2 kB     00:00    
Dependencies resolved.
================================================================================
 Package        Arch   Version               Repository                    Size
================================================================================
Installing:
 kernel         x86_64 6.12.0-55.39.1.el10_0 rhel-10-baseos-rhui-rpms     475 k
 kernel-core    x86_64 6.12.0-55.39.1.el10_0 rhel-10-baseos-rhui-rpms      17 M
 kernel-modules x86_64 6.12.0-55.39.1.el10_0 rhel-10-baseos-rhui-rpms      38 M
 kernel-modules-core
                x86_64 6.12.0-55.39.1.el10_0 rhel-10-baseos-rhui-rpms      28 M
Upgrading:
 NetworkManager x86_64 1:1.52.0-7.el10_0     rhel-10-baseos-rhui-rpms     2.2 M
 NetworkManager-cloud-setup
                x86_64 1:1.52.0-7.el10_0     rhel-10-appstream-rhui-rpms   74 k
 NetworkManager-libnm
                x86_64 1:1.52.0-7.el10_0     rhel-10-baseos-rhui-rpms     1.9 M
 NetworkManager-tui
                x86_64 1:1.52.0-7.el10_0     rhel-10-baseos-rhui-rpms     231 k
 amd-gpu-firmware
                noarch 20250812-15.7.el10_0  rhel-10-appstream-rhui-rpms   29 M
 amd-ucode-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     445 k
 atheros-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms      37 M
 brcmfmac-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     9.6 M
 cirrus-audio-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     2.3 M
 dnf            noarch 4.20.0-14.el10_0      rhel-10-baseos-rhui-rpms     476 k
 dnf-data       noarch 4.20.0-14.el10_0      rhel-10-baseos-rhui-rpms      40 k
 gnutls         x86_64 3.8.9-9.el10_0.14     rhel-10-baseos-rhui-rpms     1.4 M
 intel-audio-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     3.3 M
 intel-gpu-firmware
                noarch 20250812-15.7.el10_0  rhel-10-appstream-rhui-rpms  8.9 M
 iwlwifi-dvm-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     1.9 M
 iwlwifi-mvm-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms      64 M
 kernel-tools   x86_64 6.12.0-55.39.1.el10_0 rhel-10-baseos-rhui-rpms     1.0 M
 kernel-tools-libs
                x86_64 6.12.0-55.39.1.el10_0 rhel-10-baseos-rhui-rpms     491 k
 libarchive     x86_64 3.7.7-4.el10_0        rhel-10-baseos-rhui-rpms     414 k
 libldb         x86_64 4.21.3-113.el10_0     rhel-10-baseos-rhui-rpms     181 k
 libudisks2     x86_64 2.10.90-5.el10_0.1    rhel-10-appstream-rhui-rpms  211 k
 libxml2        x86_64 2.12.5-9.el10_0       rhel-10-baseos-rhui-rpms     692 k
 linux-firmware noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms      52 M
 linux-firmware-whence
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     109 k
 mt7xxx-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms      19 M
 nspr           x86_64 4.36.0-4.el10_0       rhel-10-appstream-rhui-rpms  135 k
 nss            x86_64 3.112.0-4.el10_0      rhel-10-appstream-rhui-rpms  738 k
 nss-softokn    x86_64 3.112.0-4.el10_0      rhel-10-appstream-rhui-rpms  402 k
 nss-softokn-freebl
                x86_64 3.112.0-4.el10_0      rhel-10-appstream-rhui-rpms  416 k
 nss-sysinit    x86_64 3.112.0-4.el10_0      rhel-10-appstream-rhui-rpms   19 k
 nss-util       x86_64 3.112.0-4.el10_0      rhel-10-appstream-rhui-rpms   85 k
 nvidia-gpu-firmware
                noarch 20250812-15.7.el10_0  rhel-10-appstream-rhui-rpms   99 M
 nxpwireless-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     978 k
 openssl        x86_64 1:3.2.2-16.el10_0.4   rhel-10-baseos-rhui-rpms     1.1 M
 openssl-libs   x86_64 1:3.2.2-16.el10_0.4   rhel-10-baseos-rhui-rpms     2.1 M
 podman         x86_64 6:5.4.0-13.el10_0     rhel-10-appstream-rhui-rpms   16 M
 python-unversioned-command
                noarch 3.12.9-2.el10_0.3     rhel-10-appstream-rhui-rpms   11 k
 python3        x86_64 3.12.9-2.el10_0.3     rhel-10-baseos-rhui-rpms      28 k
 python3-dnf    noarch 4.20.0-14.el10_0      rhel-10-baseos-rhui-rpms     640 k
 python3-libs   x86_64 3.12.9-2.el10_0.3     rhel-10-baseos-rhui-rpms     9.4 M
 python3-perf   x86_64 6.12.0-55.39.1.el10_0 rhel-10-appstream-rhui-rpms  1.9 M
 python3-requests
                noarch 2.32.4-1.el10_0       rhel-10-baseos-rhui-rpms     156 k
 realtek-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     5.3 M
 rh-amazon-rhui-client
                noarch 4.0.29-1.el10         rhui-client-config-server-10  48 k
 tiwilink-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     4.7 M
 udisks2        x86_64 2.10.90-5.el10_0.1    rhel-10-appstream-rhui-rpms  558 k
 vim-data       noarch 2:9.1.083-5.el10_0.1  rhel-10-baseos-rhui-rpms      17 k
 vim-minimal    x86_64 2:9.1.083-5.el10_0.1  rhel-10-baseos-rhui-rpms     799 k
 yum            noarch 4.20.0-14.el10_0      rhel-10-baseos-rhui-rpms      88 k

Transaction Summary
================================================================================
Install   4 Packages
Upgrade  49 Packages

Total download size: 466 M
Is this ok [y/N]: n
Operation aborted.
[ec2-user@ip-172-31-38-22 ~]$ 
[ec2-user@ip-172-31-38-22 ~]$ sudo update -y 
sudo: update: command not found
[ec2-user@ip-172-31-38-22 ~]$ sudo yum update -y
Updating Subscription Management repositories.
Unable to read consumer identity

This system is not registered with an entitlement server. You can use "rhc" or "subscription-manager" to register.

Last metadata expiration check: 0:01:30 ago on Wed Oct 15 12:37:00 2025.
Dependencies resolved.
================================================================================
 Package        Arch   Version               Repository                    Size
================================================================================
Installing:
 kernel         x86_64 6.12.0-55.39.1.el10_0 rhel-10-baseos-rhui-rpms     475 k
 kernel-core    x86_64 6.12.0-55.39.1.el10_0 rhel-10-baseos-rhui-rpms      17 M
 kernel-modules x86_64 6.12.0-55.39.1.el10_0 rhel-10-baseos-rhui-rpms      38 M
 kernel-modules-core
                x86_64 6.12.0-55.39.1.el10_0 rhel-10-baseos-rhui-rpms      28 M
Upgrading:
 NetworkManager x86_64 1:1.52.0-7.el10_0     rhel-10-baseos-rhui-rpms     2.2 M
 NetworkManager-cloud-setup
                x86_64 1:1.52.0-7.el10_0     rhel-10-appstream-rhui-rpms   74 k
 NetworkManager-libnm
                x86_64 1:1.52.0-7.el10_0     rhel-10-baseos-rhui-rpms     1.9 M
 NetworkManager-tui
                x86_64 1:1.52.0-7.el10_0     rhel-10-baseos-rhui-rpms     231 k
 amd-gpu-firmware
                noarch 20250812-15.7.el10_0  rhel-10-appstream-rhui-rpms   29 M
 amd-ucode-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     445 k
 atheros-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms      37 M
 brcmfmac-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     9.6 M
 cirrus-audio-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     2.3 M
 dnf            noarch 4.20.0-14.el10_0      rhel-10-baseos-rhui-rpms     476 k
 dnf-data       noarch 4.20.0-14.el10_0      rhel-10-baseos-rhui-rpms      40 k
 gnutls         x86_64 3.8.9-9.el10_0.14     rhel-10-baseos-rhui-rpms     1.4 M
 intel-audio-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     3.3 M
 intel-gpu-firmware
                noarch 20250812-15.7.el10_0  rhel-10-appstream-rhui-rpms  8.9 M
 iwlwifi-dvm-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     1.9 M
 iwlwifi-mvm-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms      64 M
 kernel-tools   x86_64 6.12.0-55.39.1.el10_0 rhel-10-baseos-rhui-rpms     1.0 M
 kernel-tools-libs
                x86_64 6.12.0-55.39.1.el10_0 rhel-10-baseos-rhui-rpms     491 k
 libarchive     x86_64 3.7.7-4.el10_0        rhel-10-baseos-rhui-rpms     414 k
 libldb         x86_64 4.21.3-113.el10_0     rhel-10-baseos-rhui-rpms     181 k
 libudisks2     x86_64 2.10.90-5.el10_0.1    rhel-10-appstream-rhui-rpms  211 k
 libxml2        x86_64 2.12.5-9.el10_0       rhel-10-baseos-rhui-rpms     692 k
 linux-firmware noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms      52 M
 linux-firmware-whence
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     109 k
 mt7xxx-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms      19 M
 nspr           x86_64 4.36.0-4.el10_0       rhel-10-appstream-rhui-rpms  135 k
 nss            x86_64 3.112.0-4.el10_0      rhel-10-appstream-rhui-rpms  738 k
 nss-softokn    x86_64 3.112.0-4.el10_0      rhel-10-appstream-rhui-rpms  402 k
 nss-softokn-freebl
                x86_64 3.112.0-4.el10_0      rhel-10-appstream-rhui-rpms  416 k
 nss-sysinit    x86_64 3.112.0-4.el10_0      rhel-10-appstream-rhui-rpms   19 k
 nss-util       x86_64 3.112.0-4.el10_0      rhel-10-appstream-rhui-rpms   85 k
 nvidia-gpu-firmware
                noarch 20250812-15.7.el10_0  rhel-10-appstream-rhui-rpms   99 M
 nxpwireless-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     978 k
 openssl        x86_64 1:3.2.2-16.el10_0.4   rhel-10-baseos-rhui-rpms     1.1 M
 openssl-libs   x86_64 1:3.2.2-16.el10_0.4   rhel-10-baseos-rhui-rpms     2.1 M
 podman         x86_64 6:5.4.0-13.el10_0     rhel-10-appstream-rhui-rpms   16 M
 python-unversioned-command
                noarch 3.12.9-2.el10_0.3     rhel-10-appstream-rhui-rpms   11 k
 python3        x86_64 3.12.9-2.el10_0.3     rhel-10-baseos-rhui-rpms      28 k
 python3-dnf    noarch 4.20.0-14.el10_0      rhel-10-baseos-rhui-rpms     640 k
 python3-libs   x86_64 3.12.9-2.el10_0.3     rhel-10-baseos-rhui-rpms     9.4 M
 python3-perf   x86_64 6.12.0-55.39.1.el10_0 rhel-10-appstream-rhui-rpms  1.9 M
 python3-requests
                noarch 2.32.4-1.el10_0       rhel-10-baseos-rhui-rpms     156 k
 realtek-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     5.3 M
 rh-amazon-rhui-client
                noarch 4.0.29-1.el10         rhui-client-config-server-10  48 k
 tiwilink-firmware
                noarch 20250812-15.7.el10_0  rhel-10-baseos-rhui-rpms     4.7 M
 udisks2        x86_64 2.10.90-5.el10_0.1    rhel-10-appstream-rhui-rpms  558 k
 vim-data       noarch 2:9.1.083-5.el10_0.1  rhel-10-baseos-rhui-rpms      17 k
 vim-minimal    x86_64 2:9.1.083-5.el10_0.1  rhel-10-baseos-rhui-rpms     799 k
 yum            noarch 4.20.0-14.el10_0      rhel-10-baseos-rhui-rpms      88 k

Transaction Summary
================================================================================
Install   4 Packages
Upgrade  49 Packages

Total download size: 466 M
Downloading Packages:
(1/53): kernel-6.12.0-55.39.1.el10_0.x86_64.rpm 7.6 MB/s | 475 kB     00:00    
(2/53): kernel-core-6.12.0-55.39.1.el10_0.x86_6  43 MB/s |  17 MB     00:00    
(3/53): libudisks2-2.10.90-5.el10_0.1.x86_64.rp  15 MB/s | 211 kB     00:00    
(4/53): python-unversioned-command-3.12.9-2.el1 1.1 MB/s |  11 kB     00:00    
(5/53): udisks2-2.10.90-5.el10_0.1.x86_64.rpm    25 MB/s | 558 kB     00:00    
(6/53): nspr-4.36.0-4.el10_0.x86_64.rpm          14 MB/s | 135 kB     00:00    
(7/53): nss-3.112.0-4.el10_0.x86_64.rpm          29 MB/s | 738 kB     00:00    
(8/53): nss-softokn-3.112.0-4.el10_0.x86_64.rpm  26 MB/s | 402 kB     00:00    
(9/53): nss-softokn-freebl-3.112.0-4.el10_0.x86  20 MB/s | 416 kB     00:00    
(10/53): nss-sysinit-3.112.0-4.el10_0.x86_64.rp 2.2 MB/s |  19 kB     00:00    
(11/53): nss-util-3.112.0-4.el10_0.x86_64.rpm   9.3 MB/s |  85 kB     00:00    
(12/53): kernel-modules-core-6.12.0-55.39.1.el1  36 MB/s |  28 MB     00:00    
(13/53): NetworkManager-cloud-setup-1.52.0-7.el 7.0 MB/s |  74 kB     00:00    
(14/53): podman-5.4.0-13.el10_0.x86_64.rpm       29 MB/s |  16 MB     00:00    
(15/53): kernel-modules-6.12.0-55.39.1.el10_0.x  28 MB/s |  38 MB     00:01    
(16/53): intel-gpu-firmware-20250812-15.7.el10_  22 MB/s | 8.9 MB     00:00    
(17/53): python3-perf-6.12.0-55.39.1.el10_0.x86  34 MB/s | 1.9 MB     00:00    
(18/53): libxml2-2.12.5-9.el10_0.x86_64.rpm      23 MB/s | 692 kB     00:00    
(19/53): python3-requests-2.32.4-1.el10_0.noarc  13 MB/s | 156 kB     00:00    
(20/53): libarchive-3.7.7-4.el10_0.x86_64.rpm    19 MB/s | 414 kB     00:00    
(21/53): python3-3.12.9-2.el10_0.3.x86_64.rpm   3.1 MB/s |  28 kB     00:00    
(22/53): amd-gpu-firmware-20250812-15.7.el10_0.  28 MB/s |  29 MB     00:01    
(23/53): gnutls-3.8.9-9.el10_0.14.x86_64.rpm     34 MB/s | 1.4 MB     00:00    
(24/53): NetworkManager-1.52.0-7.el10_0.x86_64.  35 MB/s | 2.2 MB     00:00    
(25/53): python3-libs-3.12.9-2.el10_0.3.x86_64.  21 MB/s | 9.4 MB     00:00    
(26/53): NetworkManager-libnm-1.52.0-7.el10_0.x  15 MB/s | 1.9 MB     00:00    
(27/53): NetworkManager-tui-1.52.0-7.el10_0.x86 9.1 MB/s | 231 kB     00:00    
(28/53): amd-ucode-firmware-20250812-15.7.el10_  27 MB/s | 445 kB     00:00    
(29/53): brcmfmac-firmware-20250812-15.7.el10_0  35 MB/s | 9.6 MB     00:00    
(30/53): cirrus-audio-firmware-20250812-15.7.el  29 MB/s | 2.3 MB     00:00    
(31/53): dnf-4.20.0-14.el10_0.noarch.rpm         24 MB/s | 476 kB     00:00    
(32/53): dnf-data-4.20.0-14.el10_0.noarch.rpm   4.2 MB/s |  40 kB     00:00    
(33/53): intel-audio-firmware-20250812-15.7.el1  16 MB/s | 3.3 MB     00:00    
(34/53): iwlwifi-dvm-firmware-20250812-15.7.el1  18 MB/s | 1.9 MB     00:00    
(35/53): atheros-firmware-20250812-15.7.el10_0.  28 MB/s |  37 MB     00:01    
(36/53): libldb-4.21.3-113.el10_0.x86_64.rpm     14 MB/s | 181 kB     00:00    
(37/53): nvidia-gpu-firmware-20250812-15.7.el10  24 MB/s |  99 MB     00:04    
(38/53): linux-firmware-whence-20250812-15.7.el 1.7 MB/s | 109 kB     00:00    
(39/53): linux-firmware-20250812-15.7.el10_0.no  18 MB/s |  52 MB     00:02    
(40/53): iwlwifi-mvm-firmware-20250812-15.7.el1  17 MB/s |  64 MB     00:03    
(41/53): nxpwireless-firmware-20250812-15.7.el1 3.4 MB/s | 978 kB     00:00    
(42/53): mt7xxx-firmware-20250812-15.7.el10_0.n  15 MB/s |  19 MB     00:01    
(43/53): openssl-3.2.2-16.el10_0.4.x86_64.rpm   5.3 MB/s | 1.1 MB     00:00    
(44/53): python3-dnf-4.20.0-14.el10_0.noarch.rp  23 MB/s | 640 kB     00:00    
(45/53): openssl-libs-3.2.2-16.el10_0.4.x86_64. 8.4 MB/s | 2.1 MB     00:00    
(46/53): yum-4.20.0-14.el10_0.noarch.rpm        6.9 MB/s |  88 kB     00:00    
(47/53): kernel-tools-6.12.0-55.39.1.el10_0.x86  30 MB/s | 1.0 MB     00:00    
(48/53): tiwilink-firmware-20250812-15.7.el10_0  37 MB/s | 4.7 MB     00:00    
(49/53): kernel-tools-libs-6.12.0-55.39.1.el10_ 8.6 MB/s | 491 kB     00:00    
(50/53): vim-data-9.1.083-5.el10_0.1.noarch.rpm 1.6 MB/s |  17 kB     00:00    
(51/53): realtek-firmware-20250812-15.7.el10_0.  23 MB/s | 5.3 MB     00:00    
(52/53): vim-minimal-9.1.083-5.el10_0.1.x86_64. 7.9 MB/s | 799 kB     00:00    
(53/53): rh-amazon-rhui-client-4.0.29-1.el10.no 409 kB/s |  48 kB     00:00    
--------------------------------------------------------------------------------
Total                                            65 MB/s | 466 MB     00:07     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Running scriptlet: nvidia-gpu-firmware-20250812-15.7.el10_0.noarch        1/1 
  Preparing        :                                                        1/1 
  Upgrading        : linux-firmware-whence-20250812-15.7.el10_0.noarc     1/102 
  Upgrading        : nspr-4.36.0-4.el10_0.x86_64                          2/102 
  Upgrading        : nss-util-3.112.0-4.el10_0.x86_64                     3/102 
  Upgrading        : openssl-libs-1:3.2.2-16.el10_0.4.x86_64              4/102 
  Upgrading        : python3-libs-3.12.9-2.el10_0.3.x86_64                5/102 
  Upgrading        : python3-3.12.9-2.el10_0.3.x86_64                     6/102 
  Upgrading        : python-unversioned-command-3.12.9-2.el10_0.3.noa     7/102 
  Upgrading        : gnutls-3.8.9-9.el10_0.14.x86_64                      8/102 
  Upgrading        : NetworkManager-libnm-1:1.52.0-7.el10_0.x86_64        9/102 
  Running scriptlet: NetworkManager-1:1.52.0-7.el10_0.x86_64             10/102 
  Upgrading        : NetworkManager-1:1.52.0-7.el10_0.x86_64             10/102 
  Running scriptlet: NetworkManager-1:1.52.0-7.el10_0.x86_64             10/102 
  Upgrading        : python3-requests-2.32.4-1.el10_0.noarch             11/102 
  Upgrading        : nss-softokn-freebl-3.112.0-4.el10_0.x86_64          12/102 
  Upgrading        : nss-softokn-3.112.0-4.el10_0.x86_64                 13/102 
  Upgrading        : nss-3.112.0-4.el10_0.x86_64                         14/102 
  Running scriptlet: nss-3.112.0-4.el10_0.x86_64                         14/102 
  Upgrading        : nss-sysinit-3.112.0-4.el10_0.x86_64                 15/102 
  Upgrading        : amd-gpu-firmware-20250812-15.7.el10_0.noarch        16/102 
  Upgrading        : intel-gpu-firmware-20250812-15.7.el10_0.noarch      17/102 
  Upgrading        : amd-ucode-firmware-20250812-15.7.el10_0.noarch      18/102 
  Upgrading        : atheros-firmware-20250812-15.7.el10_0.noarch        19/102 
  Upgrading        : brcmfmac-firmware-20250812-15.7.el10_0.noarch       20/102 
  Upgrading        : cirrus-audio-firmware-20250812-15.7.el10_0.noarc    21/102 
  Upgrading        : intel-audio-firmware-20250812-15.7.el10_0.noarch    22/102 
  Upgrading        : mt7xxx-firmware-20250812-15.7.el10_0.noarch         23/102 
  Upgrading        : nxpwireless-firmware-20250812-15.7.el10_0.noarch    24/102 
  Upgrading        : realtek-firmware-20250812-15.7.el10_0.noarch        25/102 
  Upgrading        : tiwilink-firmware-20250812-15.7.el10_0.noarch       26/102 
  Upgrading        : nvidia-gpu-firmware-20250812-15.7.el10_0.noarch     27/102 
  Upgrading        : linux-firmware-20250812-15.7.el10_0.noarch          28/102 
  Installing       : kernel-modules-core-6.12.0-55.39.1.el10_0.x86_64    29/102 
  Installing       : kernel-core-6.12.0-55.39.1.el10_0.x86_64            30/102 
  Running scriptlet: kernel-core-6.12.0-55.39.1.el10_0.x86_64            30/102 
  Installing       : kernel-modules-6.12.0-55.39.1.el10_0.x86_64         31/102 
  Running scriptlet: kernel-modules-6.12.0-55.39.1.el10_0.x86_64         31/102 
  Upgrading        : vim-data-2:9.1.083-5.el10_0.1.noarch                32/102 
  Upgrading        : kernel-tools-libs-6.12.0-55.39.1.el10_0.x86_64      33/102 
  Running scriptlet: kernel-tools-libs-6.12.0-55.39.1.el10_0.x86_64      33/102 
  Upgrading        : dnf-data-4.20.0-14.el10_0.noarch                    34/102 
  Upgrading        : python3-dnf-4.20.0-14.el10_0.noarch                 35/102 
  Upgrading        : dnf-4.20.0-14.el10_0.noarch                         36/102 
  Running scriptlet: dnf-4.20.0-14.el10_0.noarch                         36/102 
  Upgrading        : libxml2-2.12.5-9.el10_0.x86_64                      37/102 
  Upgrading        : libudisks2-2.10.90-5.el10_0.1.x86_64                38/102 
  Upgrading        : udisks2-2.10.90-5.el10_0.1.x86_64                   39/102 
  Running scriptlet: udisks2-2.10.90-5.el10_0.1.x86_64                   39/102 
  Upgrading        : libarchive-3.7.7-4.el10_0.x86_64                    40/102 
  Upgrading        : yum-4.20.0-14.el10_0.noarch                         41/102 
  Upgrading        : rh-amazon-rhui-client-4.0.29-1.el10.noarch          42/102 
  Running scriptlet: rh-amazon-rhui-client-4.0.29-1.el10.noarch          42/102 
[INFO:choose_repo] choose_repo:35 2025-10-15 12:39:08,295: Enabling binary repos in redhat-rhui.repo
[INFO:choose_repo] choose_repo:58 2025-10-15 12:39:08,296: Enabling client config repo
[INFO:choose_repo] choose_repo:66 2025-10-15 12:39:08,297: Executing [sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/redhat-rhui-client-config.repo]

  Upgrading        : kernel-tools-6.12.0-55.39.1.el10_0.x86_64           43/102 
  Upgrading        : vim-minimal-2:9.1.083-5.el10_0.1.x86_64             44/102 
  Installing       : kernel-6.12.0-55.39.1.el10_0.x86_64                 45/102 
  Upgrading        : NetworkManager-cloud-setup-1:1.52.0-7.el10_0.x86    46/102 
  Running scriptlet: NetworkManager-cloud-setup-1:1.52.0-7.el10_0.x86    46/102 
  Upgrading        : NetworkManager-tui-1:1.52.0-7.el10_0.x86_64         47/102 
  Upgrading        : python3-perf-6.12.0-55.39.1.el10_0.x86_64           48/102 
  Upgrading        : openssl-1:3.2.2-16.el10_0.4.x86_64                  49/102 
  Upgrading        : iwlwifi-dvm-firmware-20250812-15.7.el10_0.noarch    50/102 
  Upgrading        : iwlwifi-mvm-firmware-20250812-15.7.el10_0.noarch    51/102 
  Upgrading        : libldb-4.21.3-113.el10_0.x86_64                     52/102 
  Upgrading        : podman-6:5.4.0-13.el10_0.x86_64                     53/102 
  Cleanup          : NetworkManager-tui-1:1.52.0-5.el10_0.x86_64         54/102 
  Cleanup          : nss-3.112.0-1.el10_0.x86_64                         55/102 
  Cleanup          : nss-softokn-3.112.0-1.el10_0.x86_64                 56/102 
  Running scriptlet: NetworkManager-cloud-setup-1:1.52.0-5.el10_0.x86    57/102 
  Cleanup          : NetworkManager-cloud-setup-1:1.52.0-5.el10_0.x86    57/102 
  Running scriptlet: NetworkManager-cloud-setup-1:1.52.0-5.el10_0.x86    57/102 
  Running scriptlet: rh-amazon-rhui-client-4.0.27-1.el10.noarch          58/102 
  Cleanup          : rh-amazon-rhui-client-4.0.27-1.el10.noarch          58/102 
  Cleanup          : nvidia-gpu-firmware-20250708-15.6.el10_0.noarch     59/102 
  Running scriptlet: NetworkManager-1:1.52.0-5.el10_0.x86_64             60/102 
  Cleanup          : NetworkManager-1:1.52.0-5.el10_0.x86_64             60/102 
  Running scriptlet: NetworkManager-1:1.52.0-5.el10_0.x86_64             60/102 
  Cleanup          : linux-firmware-20250708-15.6.el10_0.noarch          61/102 
  Cleanup          : openssl-1:3.2.2-16.el10.x86_64                      62/102 
  Cleanup          : libarchive-3.7.7-3.el10_0.x86_64                    63/102 
  Cleanup          : nss-sysinit-3.112.0-1.el10_0.x86_64                 64/102 
  Cleanup          : kernel-tools-6.12.0-55.25.1.el10_0.x86_64           65/102 
  Cleanup          : python3-perf-6.12.0-55.25.1.el10_0.x86_64           66/102 
  Cleanup          : NetworkManager-libnm-1:1.52.0-5.el10_0.x86_64       67/102 
  Cleanup          : nss-softokn-freebl-3.112.0-1.el10_0.x86_64          68/102 
  Cleanup          : nss-util-3.112.0-1.el10_0.x86_64                    69/102 
  Running scriptlet: udisks2-2.10.90-5.el10.x86_64                       70/102 
  Cleanup          : udisks2-2.10.90-5.el10.x86_64                       70/102 
  Running scriptlet: udisks2-2.10.90-5.el10.x86_64                       70/102 
  Cleanup          : amd-gpu-firmware-20250708-15.6.el10_0.noarch        71/102 
  Cleanup          : amd-ucode-firmware-20250708-15.6.el10_0.noarch      72/102 
  Cleanup          : atheros-firmware-20250708-15.6.el10_0.noarch        73/102 
  Cleanup          : brcmfmac-firmware-20250708-15.6.el10_0.noarch       74/102 
  Cleanup          : cirrus-audio-firmware-20250708-15.6.el10_0.noarc    75/102 
  Cleanup          : intel-audio-firmware-20250708-15.6.el10_0.noarch    76/102 
  Cleanup          : intel-gpu-firmware-20250708-15.6.el10_0.noarch      77/102 
  Cleanup          : mt7xxx-firmware-20250708-15.6.el10_0.noarch         78/102 
  Cleanup          : nxpwireless-firmware-20250708-15.6.el10_0.noarch    79/102 
  Cleanup          : realtek-firmware-20250708-15.6.el10_0.noarch        80/102 
  Cleanup          : tiwilink-firmware-20250708-15.6.el10_0.noarch       81/102 
  Cleanup          : python3-requests-2.32.3-2.el10.noarch               82/102 
  Cleanup          : yum-4.20.0-12.el10_0.noarch                         83/102 
  Running scriptlet: dnf-4.20.0-12.el10_0.noarch                         84/102 
  Cleanup          : dnf-4.20.0-12.el10_0.noarch                         84/102 
  Running scriptlet: dnf-4.20.0-12.el10_0.noarch                         84/102 
  Cleanup          : python3-dnf-4.20.0-12.el10_0.noarch                 85/102 
  Cleanup          : iwlwifi-mvm-firmware-20250708-15.6.el10_0.noarch    86/102 
  Cleanup          : iwlwifi-dvm-firmware-20250708-15.6.el10_0.noarch    87/102 
  Cleanup          : python3-3.12.9-2.el10_0.2.x86_64                    88/102 
  Cleanup          : python-unversioned-command-3.12.9-2.el10_0.2.noa    89/102 
  Cleanup          : python3-libs-3.12.9-2.el10_0.2.x86_64               90/102 
  Cleanup          : vim-minimal-2:9.1.083-5.el10.x86_64                 91/102 
  Cleanup          : vim-data-2:9.1.083-5.el10.noarch                    92/102 
  Cleanup          : linux-firmware-whence-20250708-15.6.el10_0.noarc    93/102 
  Cleanup          : dnf-data-4.20.0-12.el10_0.noarch                    94/102 
  Cleanup          : openssl-libs-1:3.2.2-16.el10.x86_64                 95/102 
  Cleanup          : libudisks2-2.10.90-5.el10.x86_64                    96/102 
  Cleanup          : nspr-4.36.0-1.el10_0.x86_64                         97/102 
  Cleanup          : gnutls-3.8.9-9.el10.x86_64                          98/102 
  Cleanup          : kernel-tools-libs-6.12.0-55.25.1.el10_0.x86_64      99/102 
  Running scriptlet: kernel-tools-libs-6.12.0-55.25.1.el10_0.x86_64      99/102 
  Cleanup          : libxml2-2.12.5-8.el10_0.x86_64                     100/102 
  Cleanup          : libldb-4.21.3-106.el10_0.x86_64                    101/102 
  Cleanup          : podman-6:5.4.0-12.el10_0.x86_64                    102/102 
  Running scriptlet: kernel-modules-core-6.12.0-55.39.1.el10_0.x86_64   102/102 
  Running scriptlet: kernel-core-6.12.0-55.39.1.el10_0.x86_64           102/102 
^[[D^[[D


^CGenerating grub configuration file ...
Adding boot menu entry for UEFI Firmware Settings ...
done
warning: %posttrans(kernel-core-6.12.0-55.39.1.el10_0.x86_64) scriptlet failed, exit status 1

Error in POSTTRANS scriptlet in rpm package kernel-core
  Running scriptlet: kernel-modules-6.12.0-55.39.1.el10_0.x86_64        102/102 
  Running scriptlet: podman-6:5.4.0-12.el10_0.x86_64                    102/102 
^CThe downloaded packages were saved in cache until the next successful transaction.
You can remove cached packages by executing 'yum clean packages'.
KeyboardInterrupt: Terminated.
[ec2-user@ip-172-31-38-22 ~]$ ^C
[ec2-user@ip-172-31-38-22 ~]$ apt git install
-bash: apt: command not found
[ec2-user@ip-172-31-38-22 ~]$ git apt install
-bash: git: command not found
[ec2-user@ip-172-31-38-22 ~]$ yum install git
Not root, Subscription Management repositories not updated
Error: This command has to be run with superuser privileges (under the root user on most systems).
[ec2-user@ip-172-31-38-22 ~]$ sudo yum install git
'
Updating Subscription Management repositories.
Unable to read consumer identity

This system is not registered with an entitlement server. You can use "rhc" or "subscription-manager" to register.

Red Hat Enterprise Linux 10 for x86_64 - AppStr  79 kB/s | 4.1 kB     00:00    
Red Hat Enterprise Linux 10 for x86_64 - BaseOS  87 kB/s | 4.1 kB     00:00    
Red Hat Enterprise Linux 10 Client Configuratio  31 kB/s | 1.5 kB     00:00    
Dependencies resolved.
================================================================================
 Package          Arch   Version              Repository                   Size
================================================================================
Installing:
 git              x86_64 2.47.3-1.el10_0      rhel-10-appstream-rhui-rpms  51 k
Installing dependencies:
 git-core         x86_64 2.47.3-1.el10_0      rhel-10-appstream-rhui-rpms 4.9 M
 git-core-doc     noarch 2.47.3-1.el10_0      rhel-10-appstream-rhui-rpms 3.1 M
 perl-Error       noarch 1:0.17029-18.el10    rhel-10-appstream-rhui-rpms  46 k
 perl-File-Find   noarch 1.44-512.2.el10_0    rhel-10-appstream-rhui-rpms  26 k
 perl-Git         noarch 2.47.3-1.el10_0      rhel-10-appstream-rhui-rpms  38 k
 perl-TermReadKey x86_64 2.38-24.el10         rhel-10-appstream-rhui-rpms  40 k
 perl-lib         x86_64 0.65-512.2.el10_0    rhel-10-appstream-rhui-rpms  16 k

Transaction Summary
================================================================================
Install  8 Packages

Total download size: 8.1 M
Installed size: 37 M
Is this ok [y/N]: y
Downloading Packages:
(1/8): perl-TermReadKey-2.38-24.el10.x86_64.rpm 800 kB/s |  40 kB     00:00    
(2/8): perl-Error-0.17029-18.el10.noarch.rpm    860 kB/s |  46 kB     00:00    
(3/8): git-2.47.3-1.el10_0.x86_64.rpm           909 kB/s |  51 kB     00:00    
(4/8): perl-Git-2.47.3-1.el10_0.noarch.rpm      3.4 MB/s |  38 kB     00:00    
(5/8): perl-File-Find-1.44-512.2.el10_0.noarch. 1.7 MB/s |  26 kB     00:00    
(6/8): perl-lib-0.65-512.2.el10_0.x86_64.rpm    2.1 MB/s |  16 kB     00:00    
(7/8): git-core-2.47.3-1.el10_0.x86_64.rpm       60 MB/s | 4.9 MB     00:00    
(8/8): git-core-doc-2.47.3-1.el10_0.noarch.rpm   31 MB/s | 3.1 MB     00:00    
--------------------------------------------------------------------------------
Total                                            46 MB/s | 8.1 MB     00:00     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                        1/1 
  Installing       : git-core-2.47.3-1.el10_0.x86_64                        1/8 
  Installing       : git-core-doc-2.47.3-1.el10_0.noarch                    2/8 
  Installing       : perl-lib-0.65-512.2.el10_0.x86_64                      3/8 
  Installing       : perl-File-Find-1.44-512.2.el10_0.noarch                4/8 
  Installing       : perl-TermReadKey-2.38-24.el10.x86_64                   5/8 
  Installing       : perl-Error-1:0.17029-18.el10.noarch                    6/8 
  Installing       : git-2.47.3-1.el10_0.x86_64                             7/8 
  Installing       : perl-Git-2.47.3-1.el10_0.noarch                        8/8 
  Running scriptlet: perl-Git-2.47.3-1.el10_0.noarch                        8/8 
Installed products updated.

Installed:
  git-2.47.3-1.el10_0.x86_64               git-core-2.47.3-1.el10_0.x86_64     
  git-core-doc-2.47.3-1.el10_0.noarch      perl-Error-1:0.17029-18.el10.noarch 
  perl-File-Find-1.44-512.2.el10_0.noarch  perl-Git-2.47.3-1.el10_0.noarch     
  perl-TermReadKey-2.38-24.el10.x86_64     perl-lib-0.65-512.2.el10_0.x86_64   

Complete!
> 
> 
> ^C
[ec2-user@ip-172-31-38-22 ~]$ git clone https://github.com/Dakshprajapat1212/AWSDemo
Cloning into 'AWSDemo'...
remote: Enumerating objects: 56, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 56 (delta 0), reused 0 (delta 0), pack-reused 55 (from 1)
Receiving objects: 100% (56/56), 661.27 KiB | 2.27 MiB/s, done.
Resolving deltas: 100% (2/2), done.
[ec2-user@ip-172-31-38-22 ~]$ ls
AWSDemo
[ec2-user@ip-172-31-38-22 ~]$ cd AWSdemo
-bash: cd: AWSdemo: No such file or directory
[ec2-user@ip-172-31-38-22 ~]$ cd AWSDemo
[ec2-user@ip-172-31-38-22 AWSDemo]$ ls
assets  error  images  index.html
[ec2-user@ip-172-31-38-22 AWSDemo]$   
[ec2-user@ip-172-31-38-22 AWSDemo]$

बहुत बढ़िया सवाल Daksh — यही सोच backend और DevOps को समझने की असली शुरुआत है 💡। चलो इसे breakdown करते हैं:

---

## 🧠 Local System vs Apache Server in Production

### 🔍 Local System Serving Pages — कैसे करता है?
जब तू अपने laptop या PC पर कोई backend app चलाता है (जैसे `node app.js`, `python manage.py runserver`, या `npm run dev`), तो वो एक **development server** होता है:
- Temporary होता है
- Debugging के लिए optimized होता है
- Security और scalability नहीं होती
- अक्सर port 3000, 5000, या 8000 पर चलता है

### ❌ क्यों ये Production के लिए सही नहीं है?
- ये server crash-prone होता है
- Concurrent users handle नहीं कर सकता
- SSL/TLS नहीं होता (https)
- Logs, access control, load balancing नहीं होता

---

## ✅ Apache Server in Production — क्यों ज़रूरी है?

Apache एक **production-grade web server** है जो:

| Feature | Benefit |
|--------|---------|
| 🔒 Security | SSL, access control, authentication |
| ⚙️ Configurability | `.conf` files से fine-tuned control |
| 📈 Scalability | Multiple requests handle कर सकता है |
| 🧩 Modular | PHP, Python, CGI, reverse proxy support |
| 📊 Logging | Access logs, error logs for monitoring |
| 🔄 Static + Dynamic | HTML serve करता है और backend को proxy भी कर सकता है |

---

## 🔧 Real-World Analogy

तेरा local server ऐसा है जैसे तू अपने घर में खाना बना रहा है — सब कुछ manually, सिर्फ अपने लिए।

Apache ऐसा है जैसे तू एक restaurant चला रहा है:
- Multiple customers
- Menu control
- Security checks
- Staff coordination
- Fire safety, hygiene, etc.

---

## 🛠️ Typical Apache Setup in Production

1. Apache serves static files (`/var/www/html`)
2. Apache forwards dynamic requests to backend (Node.js, Django) via **reverse proxy**
3. Apache handles HTTPS via SSL certificates
4. Apache logs every request for audit/debugging
5. Apache runs as a **system service** — auto-restarts, monitored

---

## 🔄 Bonus: Apache + Node.js Setup

```bash
# Apache config snippet
<VirtualHost *:80>
    ServerName yourdomain.com
    ProxyPass / http://localhost:3000/
    ProxyPassReverse / http://localhost:3000/
</VirtualHost>
```

यहाँ Apache सिर्फ gateway है — actual logic Node.js में है, लेकिन Apache production-grade handling करता है.

---
Apache HTTP Server एक सबसे लोकप्रिय और widely-used open-source web server है जो static और dynamic websites को serve करने के लिए इस्तेमाल होता है। चलो इसे step-by-step समझते हैं — तुझे backend और DevOps दोनों नजरिए से clarity मिलेगी:

---

## 🔍 What is Apache Server?

- Apache एक **web server software** है जो client (browser) से आने वाले HTTP requests को handle करता है और उन्हें HTML, CSS, JS या dynamic content return करता है.
- इसे Apache Software Foundation ने develop किया है और ये free, open-source है.

---

## 🧠 Why We Use Apache?

| कारण | विवरण |
|------|-------|
| ✅ Reliable | Stable और production-grade performance देता है |
| 🔒 Secure | SSL/TLS, authentication modules, access control |
| ⚙️ Configurable | `.conf` files से behavior customize कर सकते हैं |
| 📦 Modular | PHP, Python, Perl जैसे modules add कर सकते हैं |
| 🌍 Cross-platform | Linux, Windows, macOS सब पर चलता है |

---

## ⚙️ How Apache Works (Behind the Scenes)

1. **Client Request:** Browser में कोई URL डाला जाता है → HTTP request Apache तक पहुंचती है
2. **Apache Listener:** Apache का main process उस request को सुनता है (default port: 80)
3. **Routing:** Apache config files (जैसे `httpd.conf`) के हिसाब से request को सही folder या file तक route करता है
4. **Response:** HTML, CSS, JS या dynamic output (PHP, Python) को browser को भेज देता है

---

## 🛠️ How to Use Apache (Linux EC2 Example)

### 1. Install Apache
```bash
sudo yum install httpd -y       # Amazon Linux / RedHat
sudo apt install apache2 -y     # Ubuntu/Debian
```

### 2. Start Apache Server
```bash
sudo systemctl start httpd
```

### 3. Enable on Boot
```bash
sudo systemctl enable httpd
```

### 4. Place Your Website Files
Apache default folder:
```bash
/var/www/html/
```
Place your `index.html`, assets, etc. here.

### 5. Access via Browser
```text
http://<your-public-ip>
```

---

## 🔍 Bonus: Apache vs NGINX

| Feature | Apache | NGINX |
|--------|--------|--------|
| Architecture | Process-based | Event-based |
| Static Content | Slower | Faster |
| Dynamic Content | Better with PHP | Needs FastCGI |
| Config | `.conf` files | `.conf` files |
| Use Case | Flexible, legacy apps | High-performance, modern apps |

Sources: 

---

अगर तू चाहे तो मैं तुझे Apache config file (`httpd.conf`) का breakdown दे सकता हूँ या एक demo static site host करके दिखा सकता हूँ EC2 पर. बोल, किस direction में बढ़ना है?




Apache को `httpd` के ज़रिए setup करना एक classic Linux DevOps task है — चलो इसे step-by-step practical तरीके से समझते हैं, जैसे तू EC2 या VM पर कर रहा हो:

---

## 🛠️ Apache Setup Using `httpd` (Amazon Linux / RedHat / CentOS)

### ✅ 1. Apache Install करो
```bash
sudo yum install httpd -y
```
> यह Apache HTTP Server को install करता है — इसका binary नाम ही `httpd` होता है.

---

### ✅ 2. Apache Start करो
```bash
sudo systemctl start httpd
```
> इससे Apache server चालू हो जाएगा और default port 80 पर listen करेगा.

---

### ✅ 3. Boot पर Enable करो
```bash
sudo systemctl enable httpd
```
> इससे हर बार VM boot होने पर Apache auto-start होगा.

---

### ✅ 4. Firewall में Port 80 Allow करो (अगर firewall enabled है)
```bash
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload
```

---

### ✅ 5. Website Files डालो
Apache default folder:
```bash
/var/www/html/
```
उदाहरण:
```bash
sudo cp index.html /var/www/html/
```

---

### ✅ 6. Browser से Access करो
```text
http://<your-ec2-public-ip>
```
> अगर सब सही है, तो तेरा `index.html` page दिखेगा.

---

### ✅ 7. Apache Status Check करो
```bash
sudo systemctl status httpd
```

---

## 📁 Apache Config Files

| File | Purpose |
|------|---------|
| `/etc/httpd/conf/httpd.conf` | Main config file |
| `/etc/httpd/conf.d/` | Extra config snippets |
| `/var/log/httpd/access_log` | Access logs |
| `/var/log/httpd/error_log` | Error logs |

---

## 🔄 Bonus: Restart Apache after config change
```bash
sudo systemctl restart httpd
```

-




  Installing       : perl-lib-0.65-512.2.el10_0.x86_64                      3/8 
  Installing       : perl-File-Find-1.44-512.2.el10_0.noarch                4/8 
  Installing       : perl-TermReadKey-2.38-24.el10.x86_64                   5/8 
  Installing       : perl-Error-1:0.17029-18.el10.noarch                    6/8 
  Installing       : git-2.47.3-1.el10_0.x86_64                             7/8 
  Installing       : perl-Git-2.47.3-1.el10_0.noarch                        8/8 
  Running scriptlet: perl-Git-2.47.3-1.el10_0.noarch                        8/8 
Installed products updated.

Installed:
  git-2.47.3-1.el10_0.x86_64               git-core-2.47.3-1.el10_0.x86_64     
  git-core-doc-2.47.3-1.el10_0.noarch      perl-Error-1:0.17029-18.el10.noarch 
  perl-File-Find-1.44-512.2.el10_0.noarch  perl-Git-2.47.3-1.el10_0.noarch     
  perl-TermReadKey-2.38-24.el10.x86_64     perl-lib-0.65-512.2.el10_0.x86_64   

Complete!
> 
> 
> ^C
[ec2-user@ip-172-31-38-22 ~]$ git clone https://github.com/Dakshprajapat1212/AWSDemo
Cloning into 'AWSDemo'...
remote: Enumerating objects: 56, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 56 (delta 0), reused 0 (delta 0), pack-reused 55 (from 1)
Receiving objects: 100% (56/56), 661.27 KiB | 2.27 MiB/s, done.
Resolving deltas: 100% (2/2), done.
[ec2-user@ip-172-31-38-22 ~]$ ls
AWSDemo
[ec2-user@ip-172-31-38-22 ~]$ cd AWSdemo
-bash: cd: AWSdemo: No such file or directory
[ec2-user@ip-172-31-38-22 ~]$ cd AWSDemo
[ec2-user@ip-172-31-38-22 AWSDemo]$ ls
assets  error  images  index.html
[ec2-user@ip-172-31-38-22 AWSDemo]$   
[ec2-user@ip-172-31-38-22 AWSDemo]$ Read from remote host ec2-13-235-31-22.ap-south-1.compute.amazonaws.com: Connection reset by peer
Connection to ec2-13-235-31-22.ap-south-1.compute.amazonaws.com closed.
client_loop: send disconnect: Broken pipe
╭─dakash@dakshs-MacBook-Air-2 ~/Downloads ‹main●› 
╰─$                                                                                    255 ↵
╭─dakash@dakshs-MacBook-Air-2 ~/Downloads ‹main●› 
╰─$ clear                                                                              255 ↵

╭─dakash@dakshs-MacBook-Air-2 ~/Downloads ‹main●› 
╰─$ 

╭─dakash@dakshs-MacBook-Air-2 ~/Downloads ‹main●› 
╰─$ ssh -i "devops.pem" ec2-user@ec2-13-235-31-22.ap-south-1.compute.amazonaws.com

Register this system with Red Hat Insights: rhc connect

Example:
# rhc connect --activation-key <key> --organization <org>

The rhc client and Red Hat Insights will enable analytics and additional
management capabilities on your system.
View your connected systems at https://console.redhat.com/insights

You can learn more about how to register your system 
using rhc at https://red.ht/registration
Last login: Wed Oct 15 12:32:20 2025 from 47.15.105.236
[ec2-user@ip-172-31-38-22 ~]$ sudo yum install httpd -y
Updating Subscription Management repositories.
Unable to read consumer identity

This system is not registered with an entitlement server. You can use "rhc" or "subscription-manager" to register.

Last metadata expiration check: 0:29:04 ago on Wed Oct 15 12:40:46 2025.
Dependencies resolved.
=============================================================================================
 Package               Arch      Version                Repository                      Size
=============================================================================================
Installing:
 httpd                 x86_64    2.4.63-1.el10_0.2      rhel-10-appstream-rhui-rpms     49 k
Installing dependencies:
 apr                   x86_64    1.7.5-2.el10           rhel-10-appstream-rhui-rpms    132 k
 apr-util              x86_64    1.6.3-21.el10          rhel-10-appstream-rhui-rpms    101 k
 apr-util-lmdb         x86_64    1.6.3-21.el10          rhel-10-appstream-rhui-rpms     16 k
 httpd-core            x86_64    2.4.63-1.el10_0.2      rhel-10-appstream-rhui-rpms    1.5 M
 httpd-filesystem      noarch    2.4.63-1.el10_0.2      rhel-10-appstream-rhui-rpms     13 k
 httpd-tools           x86_64    2.4.63-1.el10_0.2      rhel-10-appstream-rhui-rpms     82 k
 mailcap               noarch    2.1.54-8.el10          rhel-10-baseos-rhui-rpms        37 k
 redhat-logos-httpd    noarch    100.1-1.el10_0         rhel-10-appstream-rhui-rpms     17 k
Installing weak dependencies:
 apr-util-openssl      x86_64    1.6.3-21.el10          rhel-10-appstream-rhui-rpms     18 k
 mod_http2             x86_64    2.0.29-2.el10_0.1      rhel-10-appstream-rhui-rpms    164 k
 mod_lua               x86_64    2.4.63-1.el10_0.2      rhel-10-appstream-rhui-rpms     59 k

Transaction Summary
=============================================================================================
Install  12 Packages

Total download size: 2.2 M
Installed size: 6.1 M
Downloading Packages:
(1/12): apr-util-lmdb-1.6.3-21.el10.x86_64.rpm               323 kB/s |  16 kB     00:00    
(2/12): apr-util-openssl-1.6.3-21.el10.x86_64.rpm            343 kB/s |  18 kB     00:00    
(3/12): apr-util-1.6.3-21.el10.x86_64.rpm                    1.7 MB/s | 101 kB     00:00    
(4/12): redhat-logos-httpd-100.1-1.el10_0.noarch.rpm         1.9 MB/s |  17 kB     00:00    
(5/12): apr-1.7.5-2.el10.x86_64.rpm                          8.0 MB/s | 132 kB     00:00    
(6/12): mod_http2-2.0.29-2.el10_0.1.x86_64.rpm                11 MB/s | 164 kB     00:00    
(7/12): httpd-2.4.63-1.el10_0.2.x86_64.rpm                   4.3 MB/s |  49 kB     00:00    
(8/12): httpd-filesystem-2.4.63-1.el10_0.2.noarch.rpm        1.7 MB/s |  13 kB     00:00    
(9/12): httpd-tools-2.4.63-1.el10_0.2.x86_64.rpm             8.7 MB/s |  82 kB     00:00    
(10/12): httpd-core-2.4.63-1.el10_0.2.x86_64.rpm              49 MB/s | 1.5 MB     00:00    
(11/12): mod_lua-2.4.63-1.el10_0.2.x86_64.rpm                3.0 MB/s |  59 kB     00:00    
(12/12): mailcap-2.1.54-8.el10.noarch.rpm                    2.1 MB/s |  37 kB     00:00    
---------------------------------------------------------------------------------------------
Total                                                         14 MB/s | 2.2 MB     00:00     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                     1/1 
  Installing       : apr-1.7.5-2.el10.x86_64                                            1/12 
  Installing       : apr-util-openssl-1.6.3-21.el10.x86_64                              2/12 
  Installing       : apr-util-1.6.3-21.el10.x86_64                                      3/12 
  Installing       : apr-util-lmdb-1.6.3-21.el10.x86_64                                 4/12 
  Installing       : httpd-tools-2.4.63-1.el10_0.2.x86_64                               5/12 
  Installing       : mailcap-2.1.54-8.el10.noarch                                       6/12 
  Running scriptlet: httpd-filesystem-2.4.63-1.el10_0.2.noarch                          7/12 
  Installing       : httpd-filesystem-2.4.63-1.el10_0.2.noarch                          7/12 
  Installing       : httpd-core-2.4.63-1.el10_0.2.x86_64                                8/12 
  Installing       : mod_http2-2.0.29-2.el10_0.1.x86_64                                 9/12 
  Installing       : mod_lua-2.4.63-1.el10_0.2.x86_64                                  10/12 
  Installing       : redhat-logos-httpd-100.1-1.el10_0.noarch                          11/12 
  Installing       : httpd-2.4.63-1.el10_0.2.x86_64                                    12/12 
  Running scriptlet: httpd-2.4.63-1.el10_0.2.x86_64                                    12/12 
Installed products updated.

Installed:
  apr-1.7.5-2.el10.x86_64                       apr-util-1.6.3-21.el10.x86_64               
  apr-util-lmdb-1.6.3-21.el10.x86_64            apr-util-openssl-1.6.3-21.el10.x86_64       
  httpd-2.4.63-1.el10_0.2.x86_64                httpd-core-2.4.63-1.el10_0.2.x86_64         
  httpd-filesystem-2.4.63-1.el10_0.2.noarch     httpd-tools-2.4.63-1.el10_0.2.x86_64        
  mailcap-2.1.54-8.el10.noarch                  mod_http2-2.0.29-2.el10_0.1.x86_64          
  mod_lua-2.4.63-1.el10_0.2.x86_64              redhat-logos-httpd-100.1-1.el10_0.noarch    

Complete!
[ec2-user@ip-172-31-38-22 ~]$ cp index.html /var/www/html
cp: cannot stat 'index.html': No such file or directory
[ec2-user@ip-172-31-38-22 ~]$ ls
AWSDemo
[ec2-user@ip-172-31-38-22 ~]$ cd AWSDemo
[ec2-user@ip-172-31-38-22 AWSDemo]$ ls
assets  error  images  index.html
[ec2-user@ip-172-31-38-22 AWSDemo]$ cp index.html /var/www/html
cp: cannot create regular file '/var/www/html/index.html': Permission denied
[ec2-user@ip-172-31-38-22 AWSDemo]$ sudo cp index.html /var/www/html
[ec2-user@ip-172-31-38-22 AWSDemo]$ sudo su -
[root@ip-172-31-38-22 ~]# ls
[root@ip-172-31-38-22 ~]# exit
logout
[ec2-user@ip-172-31-38-22 AWSDemo]$ sudo cp assets /var/www/html
cp: -r not specified; omitting directory 'assets'
[ec2-user@ip-172-31-38-22 AWSDemo]$ sudo cp -r assests Connection to ec2-13-235-31-22.ap-south-1.compute.amazonaws.com closed by remote host.
Connection to ec2-13-235-31-22.ap-south-1.compute.amazonaws.com closed.
client_loop: send disconnect: Broken pipe
╭─dakash@dakshs-MacBook-Air-2 ~/Downloads ‹main●› 
╰─$ [200~ssh -i "devops.pem" ec2-user@ec2-13-235-31-22.ap-south-1.compute.amazonaws.com~
zsh: bad pattern: [200~ssh
╭─dakash@dakshs-MacBook-Air-2 ~/Downloads ‹main●› 
╰─$ ssh -i "devops.pem" ec2-user@ec2-13-235-31-22.ap-south-1.compute.amazonaws.com     255 ↵
Register this system with Red Hat Insights: rhc connect

Example:
# rhc connect --activation-key <key> --organization <org>

The rhc client and Red Hat Insights will enable analytics and additional
management capabilities on your system.
View your connected systems at https://console.redhat.com/insights

You can learn more about how to register your system 
using rhc at https://red.ht/registration
Last login: Wed Oct 15 13:09:22 2025 from 47.15.105.236
[ec2-user@ip-172-31-38-22 ~]$ cp -r error/ /var/www/hml/
cp: cannot stat 'error/': No such file or directory
[ec2-user@ip-172-31-38-22 ~]$ cd AWSDemo
[ec2-user@ip-172-31-38-22 AWSDemo]$ cp -r error/ /var/www/hml
cp: cannot create directory '/var/www/hml': Permission denied
[ec2-user@ip-172-31-38-22 AWSDemo]$ ls
assets  error  images  index.html
[ec2-user@ip-172-31-38-22 AWSDemo]$ sudo cp -r error/ /var/www/hml
[ec2-user@ip-172-31-38-22 AWSDemo]$ cd -r images/ /var/www/html
-bash: cd: -r: invalid option
cd: usage: cd [-L|[-P [-e]] [-@]] [dir]
[ec2-user@ip-172-31-38-22 AWSDemo]$ sudo cp -r error/ /var/www/html
[ec2-user@ip-172-31-38-22 AWSDemo]$ sudo cp -r images/ /var/www/html
[ec2-user@ip-172-31-38-22 AWSDemo]$ pwd
/home/ec2-user/AWSDemo
[ec2-user@ip-172-31-38-22 AWSDemo]$ cd >>
-bash: syntax error near unexpected token `newline'
[ec2-user@ip-172-31-38-22 AWSDemo]$ cd ..
[ec2-user@ip-172-31-38-22 ~]$ ls
AWSDemo
[ec2-user@ip-172-31-38-22 ~]$ cd ..
[ec2-user@ip-172-31-38-22 home]$ ls
ec2-user
[ec2-user@ip-172-31-38-22 home]$ sudo su-
sudo: su-: command not found
[ec2-user@ip-172-31-38-22 home]$ sudo -su
sudo: option requires an argument -- 'u'
usage: sudo -h | -K | -k | -V
usage: sudo -v [-ABkNnS] [-g group] [-h host] [-p prompt] [-u user]
usage: sudo -l [-ABkNnS] [-g group] [-h host] [-p prompt] [-U user]
            [-u user] [command [arg ...]]
usage: sudo [-ABbEHkNnPS] [-r role] [-t type] [-C num] [-D directory]
            [-g group] [-h host] [-p prompt] [-R directory] [-T timeout]
            [-u user] [VAR=value] [-i | -s] [command [arg ...]]
usage: sudo -e [-ABkNnS] [-r role] [-t type] [-C num] [-D directory]
            [-g group] [-h host] [-p prompt] [-R directory] [-T timeout]
            [-u user] file ...
[ec2-user@ip-172-31-38-22 home]$ ls -l /var/www/html
total 16
drwxr-xr-x. 2 root root    24 Oct 15 13:31 error
drwxr-xr-x. 2 root root    90 Oct 15 13:31 images
-rw-r--r--. 1 root root 14522 Oct 15 13:12 index.html
[ec2-user@ip-172-31-38-22 home]$ pwd
/home
[ec2-user@ip-172-31-38-22 home]$ dirname /var/www/html
/var/www
[ec2-user@ip-172-31-38-22 home]$ cd /var/www
ls -l
total 0
drwxr-xr-x. 2 root root  6 Jul 15 00:00 cgi-bin
drwxr-xr-x. 2 root root 24 Oct 15 13:30 hml
drwxr-xr-x. 4 root root 51 Oct 15 13:31 html
[ec2-user@ip-172-31-38-22 www]$ pwd
/var/www
[ec2-user@ip-172-31-38-22 www]$ systemctl start httpd
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ====
Authentication is required to start 'httpd.service'.
Authenticating as: Super User (root)
Password: 
polkit-agent-helper-1: pam_authenticate failed: Authentication failure
==== AUTHENTICATION FAILED ====
Failed to start httpd.service: Access denied
See system logs and 'systemctl status httpd.service' for details.
[ec2-user@ip-172-31-38-22 www]$ sudo systemctl start httpd
[ec2-user@ip-172-31-38-22 www]$ chkconfig https
-bash: chkconfig: command not found
[ec2-user@ip-172-31-38-22 www]$ sudo chkconfig httpd
sudo: chkconfig: command not found
[ec2-user@ip-172-31-38-22 www]$ systemctl is-enabled httpd
disabled
[ec2-user@ip-172-31-38-22 www]$ sudo systemctl enable httpd
Created symlink '/etc/systemd/system/multi-user.target.wants/httpd.service' → '/usr/lib/systemd/system/httpd.service'.
[ec2-user@ip-172-31-38-22 www]$ systemctl is-enabled httpd
enabled
[ec2-user@ip-172-31-38-22 www]$ 



