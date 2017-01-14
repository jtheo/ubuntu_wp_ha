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

192.168.123.31  be

EOF


echo "### Installation ansible repo"
apt-get install software-properties-common -y
apt-add-repository ppa:ansible/ansible -y
apt-get update -y

echo "### Installation packages"
# Install basic tools and ansible
apt-get install -y htop atop mc pwgen ipcalc curl dnsutils tmux nmap zip unrar unzip p7zip whois httping elinks links2 mtr w3m figlet toilet vnstat aria2 bzip2 sharutils ansible


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
    ControlPath ~/.ssh/cm/%r@%h:%p.socket
    ControlPersist 30m
    IdentityFile ~/.ssh/ansible
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

tail -n +$payload_start $0 | uudecode | tar -xzf -

echo "### chown Vagrant home"
chown -R vagrant.vagrant /home/vagrant
chmod 700 /home/vagrant
chmod 600 /home/vagrant/.ssh/ansible

mkdir /var/log/ansible
chown vagrant.vagrant /var/log/ansible

cd ansible

#ansible -m ping all

#sudo -u vagrant sh -c "time ansible-playbook main.yml"

echo "### Thanks for all the fish"
exit 0




begin 664 -
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
5*JB@@@HJJ*""/P7\#YXMWNH`&`$`
`
end
