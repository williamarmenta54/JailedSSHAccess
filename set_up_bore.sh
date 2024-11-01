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

wget -q https://github.com/ekzhang/bore/releases/download/v0.5.1/bore-v0.5.1-x86_64-unknown-linux-musl.tar.gz
sleep 2
tar -xf bore-v0.5.1-x86_64-unknown-linux-musl.tar.gz
sleep 2
./bore local 2222 --local-host 0.0.0.0 --to emergencyaccess.teatspray.fun --secret IhatePopUpsWut@1Ozegnos
