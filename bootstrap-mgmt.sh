#!/usr/bin/env bash

# This is just a Proof of Concept, don't put passwords or ssh-keys on github :)

# Include file

echo "### hosts file"
cat <<EOF > /etc/hosts

127.0.1.1  $(hostname)

# vagrant environment nodes
192.168.123.10  mgmt

192.168.123.11  lb

192.168.123.21  wp1
192.168.123.22  wp2

192.168.123.31  be1

EOF

wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm

yum clean all


echo "### Installation packages"
# Install basic tools and ansible
yum install -y htop atop mc pwgen ipcalc curl build-essential dnsutils tmux nmap zip unrar unzip p7zip whois httping elinks links2 mtr w3m figlet toilet vnstat aria2 vim cifs-utils gcc kernel-devel bzip2 sharutils ansible


echo "### Preparation for Ansible"

cd /home/vagrant
mkdir -p .ssh/cm

for host in mgmt lb wp1 wp2 be
do
  ssh-keyscan $host >> .ssh/known_hosts
done


cat <<EndOfLine >> .ssh/config 
Host *
    ControlMaster auto
    ControlPath ~/.ssh/cm/master-%r@%h:%p.socket
    ControlPersist 30m
EndOfLine



cat <<EndOfKey >> .ssh/ansible
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAz/5tZuUEsci/ItqhB3SyDI1LfGUVLZD3Wo1QnSrFN77hkU2E
IP53Zpv7xA5PwgdpYedGWsVzLe/N7pSrUB9+6IMtUMRjp/HiIJHEO6sBooaKdKvx
s8fI6A5rTcXIfgWa13sj59lTxVSw8dmZGrorVkx8wnH7MJ6VAZO5B8sq0gggIT1T
R6uVEODcI7GLRQ1FmERfHE24u5VoAXWMiWdfjYSVsGOtxPKTBDwuhsXQoXrxFFxK
DFmHZWcAMm0Za3A2ZhbkN0RowGbiMtlxm8eYJvbL0MPDq++FIviLNlcyl+uXCOM4
t0YUU5M4Q4WiSBYxWdc4EkD++C1TkyZMkdn9cQIDAQABAoIBAQCoWSHJt7J+B6MV
Hepac4ytdivUCqkCkaRzyY+nNngcb8Z5akl4vx57keNMw9ywink0ghJC5DAezUtc
QT8MAgIhRhOGnP6gb7p8bB9twDL5jnZAiu9+eUVW9lzJvT1TK0wx/vyH6zLPtIXn
qx0uMeNj3VLZu5H5v1GRzjRkZ4BIME/hZovQjCyD+MfYxCHe3p6mUiDAMtkABgtL
05vfjUPHeOKRu+/ijg/hUMXPDWDr16LLizHdA9Wo2H40fn8UWMkuH5Z7q/+9aj6+
uBfkwGe5sk6jm1XcJ9q0Gb74B8S7bL0m5br76uWM0Izd+I6LqN6DXxHdlFqJBWNr
PxAb6RE1AoGBAOqWaAGIcNNfld833p6BQH2JSbyz36+lV7yGB3SQBS6YNWjwaZgU
tdaNT0dVc1jJ7D4H57kWOAah/qICqj9NVXdBc9I1qDczyTVp3R7E+41aX3dekp3m
7c4NWwsiY2+bkWn1pP6QRXBbvaXBc1DG+hPQxQLjX+B+bL3kZEik7/bPAoGBAOL6
m7qBqcLfzivxqKUt7tYxxXrAF8ceoh0eL4PigJ0Cx8/5l9i9/yc2BpszrmLQTRXr
f32VbBs0YEd1561Z/fnMw7/sQdZlm1BwIh0e3lI0ngvRkfToaE8T2zsCDHU6EiOZ
NgrtCXIj3fYqE0znbjw85K6dNSQHU3bzrUzPJ9e/AoGAM3kFITD68KZMkEoGAumB
aQoyr8EYF8ZD1g3inOTs/ihPr9LwmHoS3BzthE1vnc/QklvRsH77lBj/cjT7fiBN
3Hj0HO/BFTu7roioCBRYzc9Cm0KZESSWkVvE2lCVWOvdoE5SAblOQzUeC7zCvLqs
LKTmVZfmda/H1HLEvlvSe2kCgYAB9dQeejwzGKe5LW8dbhYf93ITK1GJQLR5t+cF
JpGhyYJcQ3WSQ6HOfuLzuDCLXe0sgUoqlX3Hhl5Gf7gugRZ2b9RI9gtjhKEgwrco
tTmKUDYFOBwgl1k/RZahHdVptcSuVgZndcCdIb4rABYGlgEXuBbpgyYQV5fa8SPQ
BAH+FQKBgHltQNDtIiTzPkoVt3jjw8kQ6AEZg5IkwIZYOjMSkcZQad7ykMMeUACX
gQmaS/Xw92ehKx87P6IkL+20hCZxI/HRDGwZc+kxfIsR/XmTITXgZoz/nzXWMMnl
RB4IXCCX3fmDLM9Y0REfk2sm8lZWLi+0AEol6kSjXhjLXyGZXOJH
-----END RSA PRIVATE KEY-----
EndOfKey



echo "### unpack ansible"
payload_start=$(grep -n "^begin 664 -$" $0 | cut -d ':' -f 1)

tail -n +$payload_start $0 | uudecode | tar -tzvf -

echo "### chown Vagrant home"
chown -R vagrant.vagrant /home/vagrant
chmod 700 /home/vagrant
chmod 600 /home/vagrant/.ssh/ansible

cd ansible

ansible -m ping all

echo "### Thanks for all the fish"
exit 0



