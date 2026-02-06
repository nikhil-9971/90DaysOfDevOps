Day 13 – Linux Volume Management (LVM)

```bash
## Step 1: Create Physical Volumes (PV)

Initialize disks for LVM usage.


pvcreate /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1

## Step 2: Create Volume Group (VG)


vgcreate devops_vg /dev/nvme1n1 /dev/nvme2n1


## Step 3: Create Logical Volume (LV)


lvcreate -L 500M -n app-data devops_vg


## Verify Physical volume, Volume Group & Logical Volume


pvdisplay
vgdisplay
lvdisplay


## Step 4: Format Logical Volume


mkfs.ext4 /dev/devops_vg/app-data

### Step 5: Mount Logical Volume

## Create mount directory:


mkdir -p /mnt/app-data

## Mount the Logical Volume:

mount /dev/devops_vg/app-data /mnt/app-data

## Verify mount:


df -h /mnt/app-data


### Step 6: Extend Logical Volume Dynamically

##Increase Logical Volume size by 200MB.

lvextend -L +200M /dev/devops_vg/app-data

## Resize filesystem to reflect changes:


resize2fs /dev/devops_vg/app-data

##Verify updated size:


df -h /mnt/app-data



What you learned (3 points)

1-How to attach and use external volumes (EBS) in AWS
2-How Physical Volumes combine into Volume Groups and Logical Volumes
3-How to extend Logical Volume storage dynamically without unmounting




