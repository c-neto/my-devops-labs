yum update -y
yum install -y yum-utils epel-release 
yum install -y python3 python3-pip

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce docker-ce-cli containerd.io docker-compose

systemctl start docker
systemctl enable docker

mkdir -p /mnt/bootstrap
mount /dev/sr1 /mnt/bootstrap
cp -r /mnt/bootstrap/files/ /root/

cd /root/files/
# docker-compose pull 
