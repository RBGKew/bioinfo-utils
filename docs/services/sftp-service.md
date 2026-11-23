# Kew SFTP service 

There are two services provided by the kew SFTP:

- Public access to Kew data sets and resources
- Private sharing of data between Kew and our collaborators

## Public SFTP

This can be accessed from a browser at:

	sftp.kew.org

or via a sftp client such as FileZilla or sftp on the command line:

	Host: sftp.kew.org
	User: anonymous
	Pass: 
    Port: 22

All files are found in the `pub` directory.

### Contributing to the public SFTP

If you'd like to have data hosted on the public SFTP please contact [Matthew Clake](mailto:m.clarke@kew.org)

## Private SFTP

This service allows Kew staff to send and receive data with collaborators out side of Kew.

In order to set up the SFTP accounts contact, [Matthew Clarke](mailto:m.clarke@kew.org) with the following information:

- Name and email of each Kew staff member
- Name and email of each collaborators
- Public key for each user
- Project name if applicable

A username will be assigned and given access to the SFTP using the public key provided

### Logging in 

Use any sftp client with these details:

    Host: sftp.kew.org
    Port: 22
    User: will be provided 
    Key:  private key matching the public one sent to the admin

More detailed Instructions here:

- [SFTP Command line](../tutorials/sftp-commandline.md)
- [Filezilla](../tutorials/sftp-gui.md)

### Directory structute and access

In addition to their own directory `username_files` each user can be given access to:

- Read only access to other users files `otherusername\_files`
- Read only access to a project directoy `projectname`
- Read/Write access to project directory `projectname`

Contact [Matthew Clarke](mailto:m.clarke@kew.org) with relevant owners CC'd to request access.

### Creating a private/public key pair
Key generation instructions on the Crop Diversity HPC documentation:

- [MacOS/Linux command linei](https://help.cropdiversity.ac.uk/ssh-terminal-keys.html)
- [Windows GUI](https://help.cropdiversity.ac.uk/ssh-graphical-keys.html)



