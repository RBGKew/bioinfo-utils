## User provisioning

To create an user account connect to the sftp server (sftp.kew.org) and run the command:  

`useradd <username>`  

At the moment the moment the standard for names is the initials of first name and surname: Eduardo Toledo (et).  

The user needs to create a key pair locally and provide the administrator with he public key.  
This key needs to be added to the user profile in `/home/<username>/.ssh/authorized key`. This directory will be automatically created when the user is added with the previos command.  

To do this:  

`cd /home/<username>/.ssh`  
`nano authorizedkeys`  
Paste the complete public click and then Ctrl+x and Y to save the changes in nano.  

The user will be automatically added to two groups: contrib and ftp.  
contrib is the group to make contributions in the private part of the sftp.  
ftp is the group to make contributions in the public part of the sftp.  

Please check that once created the user is in those groups, to check it use the command:

`groups <username>`  

This command will display all the groups that the user belongs to. 

## Directory creation and contribution policy  

When an user needs to contribute privately to a Kew project we need to create  for them a directory in:  

`/srv/ftp/contrib`  
To do this:

`cd /srv/ftp/contrib`  
`mkdir <directoryname>`  

While creating the directory as root it would belong to root, therefore is neccesary to create a group associated to that project (i.e. paftol)  and give the appropiate permissions to that group on that directory.  

To create a group:  

`groupadd <groupname>`  

And then to assign the directory to that group:  

`chrgp -R <groupname> /srv/ftp/<dirname>`  
Due to a glitch with umask this command will not give writing permissions directly to the group, to amend that execute:  
`chmod g+w /srv/ftp/<dirname>`  

Finally, to add an user to a specific group:  

`usermod -a -G <groupname> <username>`  



