
# -------------------------------------------------------------------------------

# postgrest 0.3.0.1 needc glibc >= 2.14
echo "deb http://ftp.debian.org/debian experimental main" >> /etc/apt/sources.list
apt-get update
apt-get -t experimental -y install libc6
