if [[ -x "$(which btrfs)" ]]; then
  echo "Found BTRFS userspace commands"
else
  read -p $'btrfs-progs not found\nDo you want to install btrfs-progs? [y/N] ' btrfsprogs&& [[ $btrfsprogs == [yY] ]] && sudo pacman -S btrfs-progs
fi

if ! btrfs filesystem df / >&/dev/null; then
  echo "Not a BTRFS filesystem"
  exit 1
else
  echo "Found BTRFS root"
fi

if [[ -x "$(which grub-install)" ]]; then
  echo $'Found GRUB userspace commands\n\nWARNING: This does not mean GRUB is installed as your bootloader\n'
else
  read -p $'grub not found\nDo you want to install grub? [y/N] ' grub && [[ $grub == [yY] ]] && sudo pacman -S grub && echo $'\nWARNING: GRUB is not yet installed as your bootloader\nGo to https://wiki.archlinux.org/title/GRUB for installation instructions\n'
fi

if [[ -x "$(which snapper)" ]]; then
  echo $'Found snapper'
else
  read -p $'snapper not found\nDo you want to install snapper? [y/N] ' snapper && [[ $snapper == [yY] ]] && sudo pacman -S snapper && echo $'\nWARNING: Using default config, please configure\n'
fi

if [[ -x "$(which btrfs-assistant)" ]]; then
  echo $'Found btrfs-assistant'
else
  read -p $'btrfs-assistant not found\nDo you want to install btrfs-assistant? [y/N] ' assistant && [[ $assistant == [yY] ]] && sudo pacman -S btrfs-assistant
fi

if [[ `pacman -Qs | grep snap-pac` ]]; then
  echo $'Found snap-pac'
else
  read -p $'snap-pac not found\nDo you want to install snap-pac? [y/N] ' snappac && [[ $snappac == [yY] ]] && sudo pacman -S snap-pac
fi

if [[ `pacman -Qs | grep grub-btrfs` ]]; then
  echo $'Found grub-btrfs'
else
  read -p $'grub-btrfs not found\nDo you want to install grub-btrfs? [y/N] ' grubbtrfs && [[ $grubbtrfs == [yY] ]] && sudo pacman -S grub-btrfs
fi

if ! [[ `systemctl | grep grub-btrfsd.service` ]]; then
  read -p $'Do you want to start grub-btrfs daemon? [y/N] ' grubbtrfsdaemon && [[ $grubbtrfsdaemon == [yY] ]] && sudo systemctl enable grub-btrfsd && sudo systemctl start grub-btrfsd
fi
