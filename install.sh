#!/usr/bin/env bash

sudo nixos-generate-config --no-filesystems --root /mnt
sudo cp *.nix /mnt/etc/nixos
sudo cp -r /mnt/etc /mnt/persistent

sudo nixos-install --root /mnt --flake /mnt/etc/nixos#default
