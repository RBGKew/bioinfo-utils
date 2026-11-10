# Linux Permissions

In the Linux file system permissions to read, write, execute and delete files are controlled on a per file basis using file permission metedata.

Setting these p[ermissions correctly is particularly important in a multi-user envrironment such as a HPC

## Checking the Permissions of files

To see who can read, write or execute the file in a directory, use `ls -l ./directory` to get an output like this:

```bash
total 2
drwxr-xr-x. 1 username group    14 Feb 23 2025 directory
-rw-rw-r--. 1 username group   231 Apr 16 2025 file.txt
-rwxr-xr-x. 1 root     root       4402 Jun  2 2026 myscript.sh
drwx------. 1 username group    20 Mar 26 2025 private_directory
```

To this end we are interested in columss 1, 3 and 4:

 - File permission settings
 - File owner's username
 - The file's group id

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

>Be aware of who else is in the group your setting as they will have access acording to the permissions set below

## File Permissions
File permissions can be displayed symbolicly or numerically and can be changed with `chmod`:

### Symbolic Notation
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

### Numeric Notation
This notation consists of 3 or 4 positional numerals. Each per numeral is the sum of the following:

|Number to sum|Function|
|-------------|--------|
|`0`| no permissions granted |
|`1`| Execute (Sticky at position 0) |
|`2`| Write (Special Group at position 0) |
|`4`| Read (Special User at position 0) |

Positions:

0. Special and sticky (optional)
1. User Permissions
2. Group Permissions
3. Other Permissions

>Execute permissions are required for directory traversal i.e. `cd`

#### Examples:

|Symbolic|Numeric|Description|
|--------|-------|-----------|
|`-rw-r-----`|`0640`| a file with owner read/write and group read-only|
|`-rw-rw-rw-`|`0666`| a file with read and write for all users|
|`drwx------`|`0700`| a directory only accessable by the owner|


### Changing Permissions

`chmod` is used to change file permissions:

```bash
chmod u+rwx script.sh # adds read write and execute permissions for the owner
```
The permissions can be modified by adding or removing the symbolic notation.

|Symbol| Function | Description|
|------|----------|------------|
| `u`  | User   | Change permissions for the owner of the file|
| `g`  | Group  | Change permissions for users in the file's group |
| `o`  | Other  | Change permissions for users other than the owner or members of the file's group|
| `a`  | All    | Change permissions for all the above |
| `+`  | Add    | Grant permission |
| `-`  | Remove | Revoke permission|
| `r`  | Read   | Allows reading of the file |
| `w`  | Write  | Allows writing and usually deletion of the file|
| `x`  | eXicute| Allows file to be run as a program by bash|

!!! tip
use `chmod -R` to recursivly change permissions for all files and sub-directories in a directory.


#### Examples
```bash
chmod a+rw file.txt       # give everyone read/write
chmod g-w file.txt        # remove write permissions from the group
chmod -R o-rwx directory  # for all files in this directory recursivly remove read, write and execute for other users 
chmod 440 file.txt        # user and group read only
chmod 2775 directory      # set read/write/execute for user and group and read/write for others, with group special set
```

### Change all the Permissions

to change all the permissions of a directory tree, while maintaining access to directories (exicute) without giving execute to all files you can use these commands:

```bash
find ./directory -type d -exec chmod 2750 {} \; # set user rwx and group read and traversal for all directories
find ./directory -type f -exec chmod 0640 {} \; # set user rw and  group read-only for all files
```



