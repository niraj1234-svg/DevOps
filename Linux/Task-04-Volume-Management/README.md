# Task 04 – Linux Volume Management

## Objective
Create a 100 MB virtual disk, attach it as a loop device, format it with the ext4 filesystem, mount it, and verify disk usage.

## 1. Create a Virtual Disk Image

```bash
fallocate -l 100M devops_volume.img
```

Verify image size:

```bash
stat -c '%s bytes' devops_volume.img
```

Expected size: `104857600 bytes` (100 MB).

## 2. Attach the Image as a Loop Device

```bash
sudo losetup --find --show "$PWD/devops_volume.img"
```

The command returned `/dev/loop11`.

Verify:

```bash
sudo losetup -l
sudo blockdev --getsize64 /dev/loop11
```

## 3. Format with ext4

```bash
sudo mkfs.ext4 /dev/loop11
```

## 4. Create a Mount Point

```bash
sudo mkdir -p /mnt/devops_data
```

## 5. Mount the Virtual Disk

```bash
sudo mount /dev/loop11 /mnt/devops_data
```

## 6. Verify Mount and Disk Usage

```bash
df -h /mnt/devops_data
mount | grep /mnt/devops_data
```

The mounted filesystem reported approximately 90 MB of usable space. Filesystem metadata and reserved space account for the difference from the 100 MB image size.

## Tools and Concepts Used

- `fallocate` – Create a disk image.
- `losetup` – Attach a file as a loop device.
- `blockdev` – Inspect block device capacity.
- `mkfs.ext4` – Create an ext4 filesystem.
- `mount` – Attach the filesystem to a directory.
- `df -h` – Display filesystem usage.

## Result

Successfully created a 100 MB virtual disk image, attached it to `/dev/loop11`, formatted it with ext4, mounted it at `/mnt/devops_data`, and verified its filesystem capacity.

## Note

The generated `devops_volume.img` file is excluded from Git using the repository's `.gitignore` because it is a generated 100 MB binary image. The README preserves the commands needed to reproduce the practical.
