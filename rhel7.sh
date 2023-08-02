#!/bin/bash

# SECURE CONFIGURATION AUDIT SCRIPT OF RHEL 7 SERVERS
#DEVELOPED BY : PUSHKAR SINGH
#MAKE SURE TO RUN THIS SCRIPT AS ROOT/SU USER

# Function to write a line to the CSV file
write_to_csv() {
    echo "$1,\"$2\",\"$3\",\"$4\"" >> audit_results.csv
}

# Create CSV file with headers
echo "Audit Point,Check,Output,Compliant" > audit_results.csv



# Control Point 1
audit_point="IP ADDRESS "
command_output=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
check_value="N/A"
compliant="N/A"
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 2
audit_point="HOSTNAME "
command_output=$(hostname)
check_value="N/A "
compliant="N/A"

write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 3
audit_point="Ensure mounting of cramfs filesystems is disabled (Automated)"
command_output=$(modprobe -n -v cramfs | grep -E '(cramfs|install)')
check_value="install /bin/true"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 4
audit_point="Ensure mounting of squashfs filesystems is disabled"
command_output=$(modprobe -n -v squashfs | grep -E '(squashfs|install)')
check_value="install /bin/true"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 5
audit_point="Ensure mounting of udf filesystems is disabled"
command_output=$(modprobe -n -v udf | grep -E '(udf|install)')
check_value="install /bin/true"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 6
audit_point="Ensure /tmp is configured point"
command_output=$(systemctl show "tmp.mount" | grep -i "unitfilestate" | awk -F'=' '{print $2}')
check_value="enabled"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 7
audit_point="Ensure noexec option set on /tmp partition"
command_output=$(findmnt -n /tmp | grep -Ev '\bnodev\b')
check_value="no output should return"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 8
audit_point="Ensure nodev option set on /tmp partition"
command_output=$(findmnt -n /tmp -n | grep -Ev '\bnodev\b')
check_value="no output should return"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 9
audit_point="Ensure nosuid option set on /tmp partition"
command_output=$(findmnt -n /tmp -n | grep -Ev '\bnosuid\b')
check_value="no output should return"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 10
audit_point="Ensure /dev/shm is configured"
command_output=$(findmnt -n /dev/shm)
check_value="tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev,noexec,relatime,seclabel)"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 11
audit_point="Ensure noexec option set on /dev/shm partition"
command_output=$(findmnt -n /dev/shm | grep -Ev '\bnoexec\b')
check_value="no output should return"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 12
audit_point="Ensure nodev option set on /dev/shm partition"
command_output=$(findmnt -n /dev/shm | grep -Ev '\bnodev\b')
check_value="no output should return"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 13
audit_point="Ensure nosuid option set on /dev/shm partition"
command_output=$(findmnt -n /dev/shm | grep -Ev '\bnosuid\b')
check_value="no output should return"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 14
audit_point="Ensure separate partition exists for /var"
command_output=$(findmnt /var)
check_value="TARGET SOURCE FSTYPE OPTIONS /var <device> <fstype> rw,relatime,attr2,inode64,noquota"
if [  "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 15
audit_point="Ensure separate partition exists for /var/tmp"
command_output=$(findmnt /var/tmp)
check_value="TARGET SOURCE FSTYPE OPTIONS /var/tmp <device> <fstype> rw,relatime,attr2,inode64,noquota"
if [  "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 16
audit_point="Ensure /var/tmp partition includes the noexec option"
command_output=$(findmnt -n /var/tmp | grep -Ev '\bnoexec\b')
check_value="check that no output should returned"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 17
audit_point="Ensure /var/tmp partition includes the nodev option"
command_output=$(findmnt -n /var/tmp | grep -Ev '\bnodev\b')
check_value="check that no output should returned"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 16
audit_point="Ensure /var/tmp partition includes the nosuid option"
command_output=$( findmnt -n /var/tmp | grep -Ev '\bnosuid\b')
check_value="check that no output should returned"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 17
audit_point="Ensure /home partition includes the nodev option"
command_output=$(findmnt /home | grep -Ev '\bnodev\b')
check_value="check that no output should returned"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 18
audit_point="Ensure separate partition exists for /var/log"
command_output=$( findmnt /var/log)
check_value="TARGET SOURCE FSTYPE OPTIONS /var/log <device> <fstype> rw,relatime,attr2,inode64,noquota"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 19
audit_point="Ensure separate partition exists for /var/log/audit"
command_output=$( findmnt /var/log/audit)
check_value="TARGET SOURCE FSTYPE OPTIONS /var /log/audit <device> <fstype> rw,relatime,attr2,inode64,noquota"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 20
audit_point=" Ensure separate partition exists for /home "
command_output=$( findmnt /home)
check_value="TARGET SOURCE FSTYPE OPTIONS /home <device> <fstype> rw,relatime,attr2,inode64,noquota"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 21
audit_point=" Ensure /home partition includes the nodev option "
command_output=$( findmnt /home | grep -Ev '\bnodev\b')
check_value="No Output Should Return"
if [ -z "$command_output"  ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 22
audit_point="  Ensure nosuid is set on users' home directories "
command_output=$( cut -d: -f 1,3,6 /etc/passwd | egrep ":[1-4][0-9]{3}")
check_value="smithj:1001:/home/smithj & thomasr:1002:/home/thomasr  and Compare Values"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 23
audit_point="  Ensure removable media partitions include noexec option "
command_output=$( for rmpo in $(lsblk -o RM,MOUNTPOINT | awk -F " " '/1/ {print $2}'); do  findmnt -n "$rmpo" | grep -Ev "\bnoexec\b"; done)
check_value="no output should return"
if [ -z "$command_output"  ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 24
audit_point=" Ensure nodev option set on removable media partitions "
command_output=$( for rmpo in $(lsblk -o RM,MOUNTPOINT | awk -F " " '/1/ {print $2}'); do  findmnt -n "$rmpo" | grep -Ev "\bnodev\b"; done)
check_value="no output should return"
if [ -z "$command_output"  ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 25
audit_point=" Ensure nosuid option set on removable media partitions "
command_output=$( for rmpo in $(lsblk -o RM,MOUNTPOINT | awk -F " " '/1/ {print $2}'); do  findmnt -n "$rmpo" | grep -Ev "\bnosuid\b"; done)
check_value="no output should return"
if [ -z "$command_output"  ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 26
audit_point=" Ensure noexec option is configured for NFS."
command_output=$(mount | grep nfs | grep noexec)
check_value="no output should return"
if [ -z "$command_output"  ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"




# Control Point 27
audit_point=" Ensure nosuid option is set for NFS."
command_output=$(mount | grep nfs | grep nosuid)
check_value="no output should return"
if [ -z "$command_output"  ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 28
audit_point="Ensure sticky bit is set on all world-writable directories"
command_output=$(df --local -P 2> /dev/null | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null)
check_value="check that no output should returned"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 29
audit_point="Ensure all world-writable directories are group-owned."
command_output=$(find / -xdev -perm -002 -type d -fstype xfs -exec ls -lLd {} \;)
check_value="Check Output drwxrwxrwt 2 root root 40 Aug 26 13:07 /dev/mqueue "
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 30
audit_point="Disable Automounting"
command_output=$(systemctl show "autofs.service" | grep -i unitfilestate=enabled)
check_value="check that no output should returned"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 31
audit_point="Disable USB Storage"
command_output=$(modprobe -n -v usb-storage)
check_value="install /bin/true"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 32
audit_point="Ensure GPG keys are configured"
command_output=$(rpm -q gpg-pubkey --qf '%{name}-%{version}-%{release} --> %{summary}\n')
check_value="check output returned"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 33
audit_point="Ensure package manager repositories are configured"
command_output=$(yum repolist)
check_value="check output returned"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 34
audit_point="Ensure gpgcheck is globally activated"
command_output=$(grep ^\s*gpgcheck /etc/yum.conf)
check_value="gpgcheck=1"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 35
audit_point="Ensure Red Hat Subscription Manager connection is configured"
command_output=$(subscription-manager identity)
check_value="Check Output ,If connected to RHSM your systemID can be retrieved"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 36
audit_point="Disable the rhnsd Daemon"
command_output=$(systemctl is-enabled rhnsd)
check_value="Output should NOT be enabled"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 37
audit_point="Ensure software packages have been digitally signed by a Certificate Authority (CA)"
command_output=$(grep localpkg_gpgcheck /etc/yum.conf)
check_value="localpkg_gpgcheck=1"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 38
audit_point="Ensure removal of software components after update"
command_output=$( grep -i clean_requirements_on_remove /etc/yum.conf)
check_value="clean_requirements_on_remove=1"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 39
audit_point="Ensure AIDE is installed"
command_output=$(rpm -q aide)
check_value="aide-*"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 40
audit_point="Ensure filesystem integrity is regularly checked"
command_output=$(systemctl is-enabled aidecheck.service)
check_value="Enabled"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 25
#audit_point="Ensure authentication required for single user mode"
#ommand_output=$(grep /sbin/sulogin /usr/lib/systemd/system/rescue.service)
#check_value="ExecStart=-/bin/sh -c "/sbin/sulogin; /usr/bin/systemctl --fail --no-block default""
#if [ "$command_output" == "$check_value" ]; then
#    compliant="Compliant"
#else
 #   compliant="Non-Compliant"
#fi
#write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 41
audit_point="Ensure core dumps are restricted"
command_output=$(systemctl is-enabled coredump.service)
check_value="enabled or disabled"
if [ "$command_output" == "enabled" ]; then
    compliant="Compliant"
elif [ "$command_output" == "disabled" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 42
audit_point=" Ensure XD/NX support is enabled"
command_output=$(journalctl | grep 'protection: active')
check_value="kernel: NX (Execute Disable) protection: active"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 43
audit_point=" Ensure address space layout randomization (ASLR) is enabled"
command_output=$(sysctl kernel.randomize_va_space)
check_value="kernel.randomize_va_space = 2"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 44
audit_point=" Ensure prelink is not installed"
command_output=$(rpm -q prelink)
check_value="package prelink is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 45
audit_point="Ensure SELinux is installed"
command_output=$(rpm -q libselinux)
check_value="check output returned is libselinux- *"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 46
audit_point="Ensure SELinux is configured"
command_output=$( grep SELINUXTYPE= /etc/selinux/config)
check_value="SELINUXTYPE=targeted"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 47
audit_point="Ensure SELinux is configured"
command_output=$( grep SELINUXTYPE= /etc/selinux/config)
check_value="SELINUXTYPE=targeted"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 48
audit_point="Ensure SELinux is not disabled in bootloader configuration"
command_output=$(grep -P -- '^\h*(kernelopts=|linux|kernel)' $(find /boot -type f \( -name 'grubenv' -o -name 'grub.conf' -o -name 'grub.cfg' \) -exec grep -Pl -- '^\h*(kernelopts=|linux|kernel)' {} \;) | grep -E -- '(selinux=0|enforcing=0)')
check_value="Nothing Should return"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 49
audit_point=" Ensure the SELinux mode is enforcing or permissive"
command_output=$(getenforce)
check_value="Enforcing or Permissive"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 50
audit_point=" Ensure no unconfined services exist"
command_output=$( ps -eZ | grep unconfined_service_t)
check_value="No Output"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 51
audit_point="  Ensure SETroubleshoot is not installed"
command_output=$( rpm -q setroubleshoot)
check_value="package setroubleshoot is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 52
audit_point=" Ensure the MCS Translation Service (mcstrans) is not installed"
command_output=$( rpm -q mcstrans)
check_value="package mcstrans is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 53
audit_point="Ensure kernel core dumps are disabled."
command_output=$(systemctl status kdump.service)
check_value="Check Output"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 54
audit_point="Ensure message of the day is configured properly"
command_output=$(cat /etc/motd)
check_value="check output returned"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 55
audit_point="Ensure local login warning banner is configured properly"
command_output=$(cat /etc/issue)
check_value="check output returned"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 56
audit_point="Ensure remote login warning banner is configured properly"
command_output=$(cat /etc/issue.net)
check_value="check output returned"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 57
audit_point="Ensure permissions on /etc/issue are configured"
command_output=$(stat /etc/issue)
check_value="verify Uid and Gid are both 0/root and Access is 644 like Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root) "
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"




# Control Point 58
audit_point="Ensure permissions on /etc/issue.net are configured"
command_output=$(stat /etc/issue.net)
check_value="verify Uid and Gid are both 0/root and Access is 644 like Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root) "
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 59
audit_point="Ensure permissions on /etc/motd are configured"
command_output=$(stat /etc/motd)
check_value=" verify Uid and Gid are both 0/root and Access is 644 like Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"





# Control Point 60
audit_point="Ensure XDCMP is not enabled"
command_output=$(grep -Eis '^\s*Enable\s*=\s*true' /etc/gdm/custom.conf)
check_value="check output is not returned"
if [ -z "$command_output"  ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"
#------------------------------------------------------
# Control Point 61
audit_point="Ensure GNOME Display Manager is removed"
command_output=$( rpm -q gdm)
check_value="package gdm is not installed"
if [ -z "$command_output"  ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 62
audit_point="Ensure GDM login banner is configured "
command_output=$( find /etc/dconf/db/local.d/ -type f -exec grep 'banner-message-' {} \;)
check_value="Check output like banner-message-enable=true or banner-message-text='<banner message>'"
if [ -z "$command_output"  ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 34
# audit_point="Ensure updates, patches, and additional security software are installed"
# command_output=$(yum check-update)
# check_value="check output returned"
# if [ -z "$command_output"  ]; then
#     compliant="Compliant"
# else
#     compliant="Non-Compliant"
# fi
# write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 63
audit_point="Ensure unrestricted logon is not allowed"
command_output=$(grep -i timedloginenable /etc/gdm/custom.conf)
check_value="TimedLoginEnable=false"
if [ -z "$command_output"  ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 64
audit_point="Ensure xinetd is not installed"
command_output=$(rpm -q xinetd)
check_value="package xinetd is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 65
audit_point="Ensure time synchronization is in use"
command_output=$(rpm -q chrony ntp)
check_value="Check Chrony version"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 66
audit_point="Ensure NTP version"
command_output=$(rpm -q ntp)
check_value="Check NTP version"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 67
audit_point="Ensure chrony is configured"
command_output=$(grep -E "^(server|pool)" /etc/chrony.conf)
check_value="Check Output"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

#------------------------------------------------------------------
# Control Point 68
audit_point="Ensure NTP is configured"
command_output=$(systemctl is-enabled ntpd)
check_value="Enabled"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 69
audit_point="Ensure X11 Server components are not installed"
command_output=$(rpm -qa xorg-x11-server*)
check_value="Check Output"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 70
audit_point="Ensure Avahi Server are not installed"
command_output=$(rpm -q avahi-autoipd avahi)
check_value1="package avahi-autoipd is not installed"
check_value2="package avahi is not installed"
if [ "$command_output" == "$check_value1" ] || [ "$command_output" == "$check_value2" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 71
audit_point="Ensure CUPS is not installed"
command_output=$(rpm -q cups)
check_value="package cups is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 72
audit_point="Ensure DHCP Server is not installed"
command_output=$(rpm -q dhcp)
check_value="package dhcp is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 73
audit_point="Ensure LDAP Server is not installed"
command_output=$(rpm -q openldap-servers)
check_value="package openldap-servers is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 74
audit_point="Ensure DNS Server is not installed"
command_output=$(rpm -q bind)
check_value="package bind is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 75
audit_point="Ensure FTP Server is not installed"
command_output=$(rpm -q vsftpd)
check_value="package vsftpd is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 76
audit_point="Ensure HTTP Server is not installed"
command_output=$(rpm -q httpd)
check_value="package httpd is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 77
audit_point="Ensure IMAP and POP3 Server is not installed"
command_output=$(rpm -q dovecot)
check_value="package dovecot is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 78
audit_point="Ensure Samba is not installed"
command_output=$(rpm -q samba)
check_value="package samba is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 79
audit_point="Ensure HTTP Proxy Server is not installed"
command_output=$(rpm -q squid)
check_value="package squid is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 80
audit_point="Ensure net-snmp is not installed"
command_output=$(rpm -q net-snmp)
check_value="package net-snmp is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 81
audit_point="Ensure NIS Server is not installed"
command_output=$(rpm -q ypserv)
check_value="package ypserv is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 82
audit_point="Ensure Telnet Server is not installed"
command_output=$(rpm -q telnet-server)
check_value="package telnet-server is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 83
audit_point="Ensure mail transfer agent is configured for local-only mode"
command_output=$(ss -lntu | grep -E ':25\s' | grep -E -v '\s(127.0.0.1|\[?::1\]?):25\s')
check_value="No Output"
if [ -z  "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 84
audit_point="Ensure nfs-utils is not installed or the nfs-server service is masked"
command_output=$(rpm -q nfs-utils)
check_value="package nfs-utils is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 85
audit_point="Ensure rpcbind is not installed or the rpcbind services are masked"
command_output=$(rpm -q rpcbind)
check_value="package nfs-utils is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 86
audit_point="Ensure NIS Client is not installed"
command_output=$(rpm -q ypbind)
check_value="package ypbind is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 87
audit_point="Ensure RSH Client is not installed"
command_output=$(rpm -q rsh)
check_value="package rsh is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 88
audit_point="Ensure talk Client is not installed"
command_output=$(rpm -q talk)
check_value="package talk is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 89
audit_point="Ensure telnet Client is not installed"
command_output=$(rpm -q telnet)
check_value="package telnet is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 90
audit_point="Ensure LDAP Client is not installed"
command_output=$(rpm -q openldap-clients)
check_value="package openldap-clients is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 91
audit_point="Disable IPv6"
command_output=$(sysctl net.ipv6.conf.all.disable_ipv6)
check_value="net.ipv6.conf.all.disable_ipv6 = 1"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 92
audit_point="Ensure IP forwarding is disabled"
command_output=$(sysctl net.ipv4.ip_forward)
check_value="net.ipv4.ip_forward = 0"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 93
audit_point="Ensure packet redirect sending is disabled"
command_output=$(sysctl net.ipv4.conf.all.send_redirects)
check_value="net.ipv4.conf.all.send_redirects = 0"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 94
audit_point="Ensure source routed packets are not accepted"
command_output=$(sysctl net.ipv4.conf.all.accept_source_route)
check_value="net.ipv4.conf.all.accept_source_route = 0"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 95
audit_point="Ensure ICMP redirects are not accepted"
command_output=$(sysctl net.ipv4.conf.all.accept_redirects)
check_value="net.ipv4.conf.all.accept_redirects = 0"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 96
audit_point="Ensure secure ICMP redirects are not accepted"
command_output=$(sysctl net.ipv4.conf.all.secure_redirects)
check_value="net.ipv4.conf.all.secure_redirects = 0"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 97
audit_point="Ensure suspicious packets are logged"
command_output=$(sysctl net.ipv4.conf.all.log_martians)
check_value="net.ipv4.conf.all.log_martians = 1"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 98
audit_point="Ensure broadcast ICMP requests are ignored"
command_output=$(sysctl net.ipv4.icmp_echo_ignore_broadcasts)
check_value="net.ipv4.icmp_echo_ignore_broadcasts = 1"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 99
audit_point="Ensure bogus ICMP responses are ignored"
command_output=$(sysctl net.ipv4.icmp_ignore_bogus_error_responses)
check_value="net.ipv4.icmp_ignore_bogus_error_responses = 1"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 100
audit_point="Ensure Reverse Path Filtering is enabled"
command_output=$(sysctl net.ipv4.conf.all.rp_filter)
check_value="net.ipv4.conf.all.rp_filter = 1"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 101
audit_point="Ensure TCP SYN Cookies is enabled"
command_output=$(sysctl net.ipv4.tcp_syncookies)
check_value="net.ipv4.ip_forward = 0"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 102
audit_point="Ensure IPv6 router advertisements are not accepted"
command_output=$(sysctl net.ipv6.conf.all.accept_ra)
check_value="net.ipv6.conf.all.accept_ra = 0"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 103
audit_point="Ensure DCCP is disabled"
command_output=$(modprobe -n -v dccp)
check_value="install /bin/true"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 104
audit_point="Ensure SCTP is disabled"
command_output=$(modprobe -n -v sctp)
check_value="install /bin/true"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 105
audit_point="Ensure firewalld is installed"
command_output=$(rpm -q firewalld iptables)
check_value="check firewall and iptables version"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 106
audit_point="Ensure iptables-services not installed with firewalld"
command_output=$(rpm -q iptables-service)
check_value="package iptables-services is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 107
audit_point="Ensure nftables either not installed or masked with firewalld"
command_output=$(systemctl is-enabled nftables)
check_value="masked"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 108
audit_point="Ensure firewalld service enabled and running"
command_output=$(systemctl is-enabled nftables)
check_value="enabled"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 109
audit_point="Ensure iptables packages are installed"
command_output=$(rpm -q iptables iptables-services)
check_value="check output"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 110
audit_point=" Ensure nftables is installed"
command_output=$(rpm -q nftables)
check_value="check output as nftables-<version>"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 111
audit_point="  Ensure firewalld is either not installed or masked with nftables"
command_output=$(rpm -q firewalld)
check_value="package firewalld is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 111
audit_point=" Ensure iptables-services not installed with nftables"
command_output=$(rpm -q iptables-services)
check_value="package iptables-services is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 112
audit_point=" Ensure iptables are flushed with nftables"
command_output=$( iptables -L)
check_value="No rules should be returned"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 113
audit_point=" Ensure nftables service is enabled"
command_output=$( systemctl is-enabled nftables)
check_value="enabled"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 114
audit_point=" Ensure iptables packages are installed"
command_output=$( rpm -q iptables iptables-services)
check_value="Check iptables-<version>"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 114
audit_point=" Ensure nftables is not installed with iptables"
command_output=$( rpm -q nftables)
check_value="package nftables is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 115
audit_point=" Ensure firewalld is either not installed or masked with iptables"
command_output=$( rpm -q firewalld)
check_value="package firewalld is not installed"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 116
audit_point="Ensure iptables is enabled and running"
command_output=$(systemctl is-enabled iptables)
check_value="enabled"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 117
audit_point="Ensure ip6tables is enabled and running"
command_output=$(systemctl is-enabled ip6tables)
check_value="enabled"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 118
audit_point="Ensure auditd is installed"
command_output=$(rpm -q audit audit-libs)
check_value="Check output"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 119
audit_point="Ensure auditd service is enabled and running"
command_output=$(systemctl is-enabled auditd)
check_value="enabled"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 120
audit_point="Ensure audit log storage size is configured"
command_output=$(grep max_log_file /etc/audit/auditd.conf | awk '{output=output " " $0} END{print output}')
check_value="Check output is max_log_file = <MB>"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 121
audit_point="Ensure audit logs are not automatically deleted"
command_output=$(grep max_log_file_action /etc/audit/auditd.conf)
check_value="check max_log_file_action = keep_logs"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 122
audit_point="Ensure audit system is set to single when the disk is full"
command_output=$(grep -i disk_full_action /etc/audisp/audisp-remote.conf)
check_value="disk_full_action = single"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 123
audit_point="Ensure rsyslog is installed"
command_output=$(rpm -q rsyslog)
check_value="check version"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 124
audit_point="Ensure rsyslog Service is enabled and running"
command_output=$(systemctl is-enabled rsyslog)
check_value="enabled"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 125
audit_point="Ensure permissions on all logfiles are configured"
command_output=$(find /var/log -type f -perm /g+wx,o+rwx -exec ls -l {} \;)
check_value="No Output "
if [ -z "$command_output"  ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"




# Control Point 126
audit_point="ensure sudo is installed"
command_output=$(rpm -q sudo)
check_value="Check Version"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 127
audit_point="Ensure sudo commands use pty"
command_output=$(grep -Ei '^\s*Defaults\s+([^#]\S+,\s*)?use_pty\b' /etc/sudoers)
check_value="Defaults use_pty"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 128
audit_point="Ensure permissions on /etc/ssh/sshd_config are configured"
command_output=$(stat /etc/ssh/sshd_config)
check_value="Check Output if verify Uid and Gid are both 0/root and Access does not grant permissions to group or other"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 129
audit_point="Ensure permissions on SSH private host key files are configured"
command_output=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec stat {} \;)
check_value="Check Output if verify Uid is 0/root and Gid is either 0/root or {gid}/ssh_keys and permissions are 0640 or more restrictive"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 130
audit_point="Ensure permissions on SSH public host key files are configured"
command_output=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec stat {} \;)
check_value="Check Output if verify Access does not grant write or execute permissions to group or other for all returned files:"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 131
audit_point="Ensure password creation requirements are configured"
command_output=$(cat /etc/security/pwquality.conf | grep minlen | grep -o '[[:digit:]]*')
check_value="14 or more"
if [ $((command_output)) -ge 14 ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 132
audit_point="Cheking the password Complexity"
command_output=$(cat /etc/security/pwquality.conf | grep minclass)
check_value="the required password complexity is minclass = 4"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 133
audit_point="Ensure lockout for failed password attempts is configured"
command_output=$(cat /etc/pam.d/system-auth | grep -E '^\s*auth\s+\S+\s+pam_(faillock|unix)\.so' )
check_value="Check Output"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"



# Control Point 134
audit_point="Ensure password hashing algorithm is SHA-512"
command_output=$(grep "^ENCRYPT_METHOD" /etc/login.defs | grep -o "SHA512")
check_value="sha512"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 135
audit_point="Ensure password reuse is limited"
command_output=$(grep -E "password\s+requisite\s+pam_pwquality.so" /etc/pam.d/system-auth /etc/pam.d/password-auth)
check_value="check if 'pam_pwquality.so' module is configured with 'remember' parameter"
if [ -z "$command_output" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi

write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 136
audit_point="Ensure password expiration is 365 days or less"
command_output=$(cat /etc/login.defs | grep PASS_MAX_DAYS)
check_value="Check output"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 137
audit_point="Ensure default group for the root account is GID 0"
command_output=$(cat /etc/passwd |grep "root" | awk -F: '{print $4}')
check_value="0"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# # Control Point 97
# audit_point="Ensure root login is restricted to system console"
# command_output=$(cat /etc/securetty)
# check_value="Check Output"
# if [ "$command_output" == "$check_value" ]; then
#     compliant="Compliant"
# else
#     compliant="Non-Compliant"
# fi
# write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 138
audit_point="Ensure permissions on /etc/passwd are configured"
command_output=$(stat /etc/passwd)
check_value="Check and Verify that Uid and Gid are both 0/root and Access is 644 or more restrictive"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 139
audit_point="Ensure permissions on /etc/passwd- are configured"
command_output=$(stat /etc/passwd)
check_value="Check and Verify that Uid and Gid are both 0/root and Access is 644 or more restrictive"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 140
audit_point="Ensure permissions on /etc/shadow are configured"
command_output=$(stat /etc/shadow)
check_value="Check and verify Uid and Gid are 0/root , and Access is 0000"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 141
audit_point="Ensure permissions on /etc/gshadow- are configured"
command_output=$(stat /etc/gshadow)
check_value="Check and verify Uid and Gid are 0/root , and Access is 0000"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 142
audit_point="Ensure permissions on /etc/group- are configured"
command_output=$(stat /etc/group)
check_value="verify Uid and Gid are both 0/root and Access is 644 or more restrictive"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 143
audit_point="Ensure root is the only UID 0 account"
command_output=$(awk -F: '($3 == 0) { print $1 }' /etc/passwd)
check_value="root"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"


# Control Point 144
audit_point="Ensure SSH X11 forwarding is disabled"
command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i x11forwarding)
check_value="x11forwarding no"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"

# Control Point 145
audit_point="Ensure SSH MaxAuthTries is set to 4 or less"
command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep maxauthtries)
check_value="maxauthtries 4"
if [ "$command_output" == "$check_value" ]; then
    compliant="Compliant"
else
    compliant="Non-Compliant"
fi
write_to_csv "$audit_point" "$check_value" "$command_output" "$compliant"
















# Add more control points as needed


echo "Audit completed. Results are stored in audit_results.csv file."
