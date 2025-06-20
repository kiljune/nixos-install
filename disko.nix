{device ? throw "Set this to your disk device, e.g. /dev/sda", ...}: {
  disko.devices = {
    disk.main = {
      #device = "/dev/disk/by-id/ata-2.5__SSD_512GB_CL2025022400573K";
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            name = "ESP";
            start = "1M";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
            };
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "root_vg";
            };
          };
        };
      };
    };
    lvm_vg = {
      root_vg = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = ["-f"];

              subvolumes = {
                "@rootfs" = {
                  mountpoint = "/";
                };
                "@home" = {
                  mountOptions = ["noatime" "compress=zstd"];
                  mountpoint = "/home";
                };
                "@persistent" = {
                  mountOptions = ["noatime" "compress=zstd"];
                  mountpoint = "/persistent";
                };
                "@nix" = {
                  mountOptions = ["noatime" "compress=zstd"];
                  mountpoint = "/nix";
                };
              };
            };
          };
        };
      };
    };
    nodev = {
      "/tmp" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=4G"
        ];
      };
    };
  };
}
