echo 'CLEAN SCRIPT'

echo '1. apt-get autoremove'
sudo apt-get autoremove

echo '2. clean apt cache'
sudo du -sh /var/cache/apt 
sudo apt-get clean

echo '3. clean thumbnails cache'
du -sh ~/.cache/thumbnails
rm -rf ~/.cache/thumbnails/*

echo '4. remove old snaps'
du -h /var/lib/snapd/snaps
set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done

