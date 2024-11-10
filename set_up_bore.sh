#!/bin/sh
export DEBIAN_FRONTEND=noninteractive
apt update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata wget curl git cmake binutils build-essential nano openssh-server python3 python3-pip dropbear screen net-tools dpkg >/dev/null

ln -fs /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata 
sleep 2


cat > /etc/default/dropbear <<END
NO_START=0
DROPBEAR_PORT=2299
DROPBEAR_EXTRA_ARGS=
DROPBEAR_BANNER=""
DROPBEAR_RECEIVE_WINDOW=65536
END

sleep 2

cat > /etc/ssh/sshd_config <<EOR
Port 2222
PermitRootLogin yes
PasswordAuthentication yes
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem       sftp    /usr/lib/openssh/sftp-server
EOR

sleep 2

echo "root:Pmataga87465622" | chpasswd
sleep 2
service dropbear restart
sleep 2
service ssh restart
sleep 2
netstat -ntlp
sleep 2

curl -s https://github.com/fatedier/frp/releases/download/v0.48.0/frp_0.48.0_linux_amd64.tar.gz -L -O -J
tar -xvf frp_0.48.0_linux_amd64.tar.gz
# start from daemon
cp frp_0.48.0_linux_amd64/frpc /usr/bin
mkdir /etc/frp
mkdir /var/frp  # log

sleep 2

cat > /etc/frp/frpc.ini <<END
[common]
server_addr = emergencyaccess.teatspray.fun
server_port = 7000

[ssh.manojamcunukelwamybinder]
type = tcp
local_ip = 127.0.0.1
local_port = 2222
remote_port = 12302
subdomain = manojamcunukelwamybinder

END

sleep 2

#manojamcunukelwamybinder.emergencyaccess.teatspray.fun

/usr/bin/frpc -c /etc/frp/frpc.ini
