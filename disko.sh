#!/usr/bin/env bash

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount disko.nix --arg device '"/dev/disk/by-id/ata-2.5__SSD_512GB_CL2025022400573K"'

lsblk
