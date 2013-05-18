pacman -Sy  sudo bc gvim git ifplugd nfs-utils yp-tools ypbind-mt openssh yaourt libxml2 dbus ntp

yaourt -S torque

file="/etc/pacman.conf"
word="archlinuxfr"

cmd=$(grep -ci "$word" $file)

if [ "$cmd" != "0" ]; then
	echo "archlinufr already set"
else
        echo "[archlinuxfr]" >> $file
        echo "SigLevel = Never" >> $file
        echo "Server = http://repo.archlinux.fr/\$arch" >> $file
fi

file="/etc/pacman.conf"
word="archlinuxfr"
cmd=$(grep -ci "$word" $file)

#configuring nis
echo "ypserver fiscomp" > /etc/yp.conf
echo 'NISDOMAINNAME="fiscomp"' >  /etc/nisdomainname
cp nsswitch.conf /etc/nsswitch.conf
systemctl enable ypbind.service
systemctl enable rpcbind 
#deprecated
echo 'NISDOMAINNAME="fiscomp"' >  /etc/conf.d/nisdomainname

#setting torque node
echo "\$pbsserver      pinot  # note: this is the hostname of the headnode" > /var/spool/torque/mom_priv/config
systemctl enable torque-node.service

#setting the network
systemctl enable sshd.service
cp network.service /etc/systemd/system/ 
systemctl enable network.service
#uset other network services
systemctl disable net-auto-wired 
systemctl disable NetworkManager 
#persistent network name
ln -s /dev/null /etc/udev/rules.d/80-net-name-slot.rules

#Enabling ntp to set the clock right 
systemctl enable ntpd 
timedatectl set-timezone America/Sao_Paulo
cp ntp.conf /etc
