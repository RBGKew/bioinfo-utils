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

### Contributing to the public SFTP

If you'd like to have data hosted on the public SFTP please contact [Matthew Clake](mailto:m.clarke@kew.org) or  [Reinis Rozkalns](r.rozkalns@kew.org)

## Private SFTP

This service allows Kew staff to send and receive data with collaborators out side of Kew.

In order to set up the SFTP accounts contact, [Matthew Clarke](mailto:m.clarke@kew.org) with the following information:

- a project name
- Name and email of Kew staff member
- name and email for all collaborators
- a Public key for each user

A username will be assigned and given access to the sftp using the public key provided

### Logging in and tansfering data
Use any sftp client with these details:

    Host: sftp.kew.org
    Port: 22
    User: will be provided (usually in project-name format)
    Key:  private key matching the public one sent to the admin

More detailed Instructions here:

- [SFTP Command line](../tutorials/sftp-commandline.md)
- [Filezilla](../tutorials/sftp-gui.md)

### Creating a private/public key pair
Key generation instructions on the Crop Diversity HPC documentation:

- [MacOS/Linux command linei](https://help.cropdiversity.ac.uk/ssh-terminal-keys.html)
- [Windows GUI](https://help.cropdiversity.ac.uk/ssh-graphical-keys.html)



