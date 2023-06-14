### Transfer Data
#### From Windows
Using an SFTP client such as [FileZilla](https://filezilla-project.org/download.php?platform=win64)

In Filezilla use the Quickconnect bar or Site Manager and enter:

	Host: sftp://kewhpc
	Username: yourkewusername
	Password: yourkewpassword
	Port: 22 

#### From MacOS / Linux
[FileZilla](https://filezilla-project.org) works the same on as on Windows but for larger files or whole directories you can use rsync via the terminal.

Copying to kewhpc:

	rsync -avP /local/file/or/directory username@kewhpc://directory/to/copy/to

Copying from kewhpc:

	rsync -avP username@kewhpc://file/or/directory/to/copy /local/destination/for/files

If you want to copy a directories contents and not the directory itself add a trailing "/" to the first argument.
If the rsync command is interrupted just re-run the exact command and its should continue from the file it was last transferring.

