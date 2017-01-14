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
E2_SOC+Z"_:>Z'WBWBXJ_*ZB@@@HJJ*"""OX4\#\++UQ^`!@!````
`
end
