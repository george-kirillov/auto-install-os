#!/bin/bash
user=service_user

# create dir for keys & ops keys
mkdir /home/$user/.ssh/ && \
cat <<EOF > /home/$user/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxYL9uWd1fDK00zbFf8iZio2pYLb3fhz5t+EQVBBK/uf2dgWQRJtbXKADlG4YUJJzzyKbPYUlqwWkPjtItSA0NvUH8Za+RQz12FE5DL5RG+04eVxqFNUPYKWiMSMJsU2ABPETf4Egy7KeM0hL6xWApcrWso0SD039tJr/PiAJ0qFuswaxTB7C1qDoh3LKhPtNINLotUnCGfOMjjGG1aDQx3ECYpqYHzltaanQ3qKA9YModW18gJoTF5ApK8dbtgqqAE6A2ilB9+MtKTb0IanPGjrPtkKL2zn9Vww/d1T0FoiDijWpfyJnVk0L9Y1dpdka/7xlOZM3JbEPr9kQ6bo/H kirillov@kirillov-pc
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDi56DiCzvnuPfTco634BhpF7L+jxAJLl0EyfU2+sDQHfNOT0vOvBJ7SsRZLS1K0t1//lrdPhsutzoxDcFBlXUDWtVsfDYM155SJut/gfPn9CiTMj0P5thUzvEmo9Nc9mw+8f9EOYKtq3dm7OuXvb6CV0NSS4kdImn6GNudetN9wiEzMoVcgu5M/796adPKoeDp//EAb13yKBFyEHDKb9wo3YrUyKNZqrar1RiZpOEIgKBMFCksMKOlJWjtIHrVOz5wmQLCMpBkqwIEhy0Xjui6T0OFfKwrJNzjRJGdliFtMyg8iWF+ebdyzXYkgN9hJ00/1b5IyaHOnp76dXghWdBx george
EOF

# sudo no passwd for service_user
cat <<EOF >> /etc/sudoers
$user ALL=(ALL) NOPASSWD:ALL
EOF

# fix permissions
chown -R $user:$user /home/$user/

rm -- "$0"
