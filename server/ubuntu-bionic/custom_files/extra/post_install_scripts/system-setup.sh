#!/bin/bash
user=service_user

# install Packages
apt-add-repository --yes --update ppa:ansible/ansible
apt-get update && apt-get install -y --force-yes \
software-properties-common \
openssh-server \
ansible


# create dir for keys & ops keys
mkdir /home/$user/.ssh/ && \
cat <<EOF > /home/$user/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxYL9uWd1fDK00zbFf8iZio2pYLb3fhz5t+EQVBBK/uf2dgWQRJtbXKADlG4YUJJzzyKbPYUlqwWkPjtItSA0NvUH8Za+RQz12FE5DL5RG+04eVxqFNUPYKWiMSMJsU2ABPETf4Egy7KeM0hL6xWApcrWso0SD039tJr/PiAJ0qFuswaxTB7C1qDoh3LKhPtNINLotUnCGfOMjjGG1aDQx3ECYpqYHzltaanQ3qKA9YModW18gJoTF5ApK8dbtgqqAE6A2ilB9+MtKTb0IanPGjrPtkKL2zn9Vww/d1T0FoiDijWpfyJnVk0L9Y1dpdka/7xlOZM3JbEPr9kQ6bo/H kirillov@kirillov-pc
EOF

# sudo no passwd for service_user
cat <<EOF >> /etc/sudoers
$user ALL=(ALL) NOPASSWD:ALL
EOF

# fix permissions
chown -R $user:$user /home/$user/

rm -- "$0"
