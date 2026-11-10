# Linux Permissions

In Linux file systems access to read, write, modify and delete files are controlled on a per file basis using file permission metedata.

This is particuylarly important in a multi user evrironment such as a HPCt

for example if you type 'ls -l' you ge an output like this:

```bash
total 2
drwxr-xr-x. 1 username usergroup    14 Feb 23 2025 directory
-rw-rw-r--. 1 username usergroup   231 Apr 16 2025 file.txt
-rwxr-xr-x. 1 root     root       4402 Jun  2 2026 myscript.sh
drwx------. 1 username usergroup    20 Mar 26 2025 private_directory
```

For discussion of Permissions we are interested in columss 1, 3 and 4 which are:

 - the File permission settings
 - the user owner
 - the group owner

## File Ownership

All Files in the Linux filesystem have an owner and a group for which permissions are set independantly

To change the ownership of a file use the `chown` command:

```bash
chown usrnm:usrgrp file.txt
```
Most of the time you'll need to do this as root (or via sudo) since you need to be able to modify files as both users.

To only change the group of a file you own you can use the `chgrp` command:

```bash
chgrp newgrp file.txt
```
>[!WARNING]
>Be aware of who else is in the group your setting as they will have access acording to the permissions set below


## File Permissions

File permissions can be displayed symbolicly or numerically and can be changed with `chmod`:

### symbolic notation

The symbolic notation consists of 10 positional characters



|Symbol| Function | Description|
|------|----------|------------|
| `-`  | Not Set  | The permission is denied|
| `d`  | Directory| The file is a Directory (position one only)|
| `r`  | Read     | Allows reading of the file |
| `w`  | Write    | Allows writing and usually deletion of the file|
| `x`  | eXicute  | Allows file to be run as a program by bash|
| `s`  | Special  | Forecs execution as the files user or group. When set for the group on a directory, all new file with in the directory inherit the group id|
| `t`  | sTicky   | When set on a directory it prevents deletion of files inside by anyone other than the owner and root|

Positions:
1. Directory
2. User Read
3. User Write
4. User Exicute and special
5. Group Read
6. Group Write
7. Group Exicute and special
8. Other Read
9. Other Write
10. Other Exicute and Sticky

### numeric notation
This notation consists of 3 or 4 positional numerals. Each per numeral is the sum of the following:

`0` no permissions granted
`1` Execute (Sticky at position 0)
`2` Write (Special Group at position 0)
`4` Read (Special User at position 0)

Positions:

0. Special and sticky (optional)
1. User Permissions
2. Group Permissions
3. Other Permissions

>[!TIP]
>Execute permissions are required to `cd` or list a directory 

### Examples:

|Symbolic|Numeric|Description|
|--------|-------|-----------|
|`-rw-r-----`|`0640| a file with owner read/write and group read-only|
|`-rw-rw-rw-`|`0666`| a file with read and write for all users|
|`drwx------`|`0700`| a directory only accessable by the owner|


### Changing Permissions

`chmod` is used to change file permissions:

```bash
chmod a+rw file.txt
chmod g-w file.txt
chmod -R o-rwx directory
```


