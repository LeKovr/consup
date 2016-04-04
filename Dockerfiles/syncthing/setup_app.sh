
curl -s https://syncthing.net/release-key.txt | apt-key add -
echo "deb http://apt.syncthing.net/ syncthing release" | tee /etc/apt/sources.list.d/syncthing-release.list

apt-get update
apt-get install syncthing

