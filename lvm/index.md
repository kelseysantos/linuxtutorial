# How To work with LVM

 - Creating Physical Volumes, Volume Groups, and Logical Volumes, To create physical volumes on top of /dev/sdb, /dev/sdc, and /dev/sdd, do:
```shell
pvcreate /dev/sdb /dev/sdc /dev/sdd
```
 - And get detailed information about each PV with:
```shell
pvdisplay /dev/sdX
```
 - If you omit /dev/sdX as parameter, you will get information about all the PVs.
```shell
vgcreate vg00 /dev/sdb /dev/sdc
```
 - As it was the case with physical volumes, you can also view information about this volume group by issuing:
```shell
vgdisplay vg00
```
 - Since vg00 is formed with two 8 GB disks, it will appear as a single 16 GB drive:
```shell
lvcreate -n vol_projects -L 10G vg00
lvcreate -n vol_backups -l 100%FREE vg00
```
> As before, you can view the list of LVs and basic information with:
```shell
lvs
```
> and detailed information with
```
lvdisplay
```
> To view information about a single LV, use lvdisplay with the VG and LV as parameters, as follows:
```shell
lvdisplay vg00/vol_projects
```
 - In the image above we can see that the LVs were created as storage devices (refer to the LV Path line). Before each logical volume can be used, we need to create a filesystem on top of it.
```shell
mkfs.ext4 /dev/vg00/vol_projects
mkfs.ext4 /dev/vg00/vol_backups
```
 - In the next section we will explain how to resize logical volumes and add extra physical storage space when the need arises to do so.
```shell
lvreduce -L -2.5G -r /dev/vg00/vol_projects
lvextend -l +100%FREE -r /dev/vg00/vol_backups
```
> It is important to include the minus (-) or plus (+) signs while resizing a logical volume. Otherwise, you’re setting a fixed size for the LV instead of resizing it.

 - To add /dev/sdd to vg00, do
```
vgextend vg00 /dev/sdd
```
> If you run vgdisplay vg00 before and after the previous command, you will see the increase in the size of the VG:
```
vgdisplay vg00
```
```
blkid /dev/vg00/vol_projects
blkid /dev/vg00/vol_backups
```
> Find Logical Volume UUID

 - Create mount points for each LV:
```
mkdir /home/projects
mkdir /home/backups
```
> and insert the corresponding entries in /etc/fstab (make sure to use the UUIDs obtained before):
>
> UUID=b85df913-580f-461c-844f-546d8cde4646 /home/projects	ext4 defaults 0 0
>
> UUID=e1929239-5087-44b1-9396-53e09db6eb9e /home/backups ext4	defaults 0 0
 - Then save the changes and mount the LVs:
```
mount -a
mount | grep home
```
[FONTE](https://www.tecmint.com/manage-and-create-lvm-parition-using-vgcreate-lvcreate-and-lvextend/)