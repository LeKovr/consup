

# lsyncd > 2.1 needc glibc >= 2.14
echo "deb http://ftp.debian.org/debian experimental main" >> /etc/apt/sources.list
echo "deb http://ftp.debian.org/debian sid main" >> /etc/apt/sources.list
apt-get update
apt-get -t experimental -y install libc6

# Required after libc update
localedef en_US.UTF-8 -i en_US -fUTF-8
localedef ru_RU.UTF-8 -i ru_RU -fUTF-8


apt-get -y install lsyncd
