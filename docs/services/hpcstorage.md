# Kew Storage
Kew storage is a storage server for medium/long term storage of scientific data. 

Key points:

- This replaces the /science mount on KewHPC.
- Data is mirrored between Kew and Wakehurst on redundant storage.
- Acessable only in Kew's network

** Please store all data in /science/users_area or /science/projects. Don't store any data in /home this has very limited space and could be wiped without warning. **

## Methods of connection

hpcstorage can be accessed via ssh and sftp while in Kew's network (onsite or [VPN](./remote_access.md))

Details:
Host: `hpcstorage`
Port: `22`
User: Your Kew username in format: `usr00kg` or `usr00wk`
Password: Your Kew password

### Command line Linux/MacOS
use these commands to connect to the server (substitute `usr00kg` for your username).

- ssh:  `ssh usr00kg@hpcstorage`
- sftp: `sftp user00kg@hpcstorage`

For Graphical user interfaces see:
- [SSH via Graphical user interface (for Crop diversity HPC)](https://help.cropdiversity.ac.uk/ssh-graphical-pw.html)
- [SFTP Via Graphical user interface](../tutorials/sftp-gui.md)


## Transfering data to/from the Crop Diversity HPC

You can transfer data to and from the Crop Diversity HPC via ssh based methods (rsync,scp). [Full instructions here](https://help.cropdiversity.ac.uk/file-transfers.html#command-line-options)

** Due to firewall restrictions you'll need to run the command from hpcstorage for both sending and receiving data **


