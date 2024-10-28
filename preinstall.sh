#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Run this script with root"
  exit
fi

read -p "Enter hostname: " hostname
read -sp "Enter password for root: " root_password
echo
read -p "Enter username: " user
read -sp "Enter password for user: " user_password
echo
read -p "EFI partition (Example: /dev/nvme0n1p1): " efi
read -p "Swap partition (Example: /dev/nvme0n1p2): " swap
read -p "Root partition (Example: /dev/nvme0n1p3): " root
echo

# Formatting file systems
mkfs.fat -F32 $efi
mkswap $swap
mkfs.ext4 $root

# Mounting partitions
mount $root /mnt
mkdir -p /mnt/boot/efi
mount $efi /mnt/boot/efi
swapon $swap

# Installing basic packages
pacstrap /mnt base linux linux-firmware sof-firmware intel-ucode base-devel grub efibootmgr nano networkmanager

# Generating fstab
genfstab /mnt > /mnt/etc/fstab

# Entering the chroot
arch-chroot /mnt /bin/bash <<EOF

# Time zone
ln -sf /usr/share/zoneinfo/Universal /etc/localtime
hwclock --systohc

# Language
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf

echo "$hostname" > /etc/hostname

echo -e "$root_password\n$root_password" | passwd

useradd -m -G wheel -s /bin/bash $user
echo -e "$user_password\n$user_password" | passwd $user

sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

systemctl enable NetworkManager

grub-install /dev/nvme0n1
grub-mkconfig -o /boot/grub/grub.cfg

EOF

umount -R /mnt
reboot
