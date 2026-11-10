# SFTP commandline tool - MacOS/Linux

## connect with passoword
you can connect to sftp using password autentication with this command:

    sftp user@host
then enter your password when prompted (it won't show the characters as you type, just hit enter when done)

## Connect with Key Pair Authentication
Once the public key has been set on the server you can connect to the sftp specifying the private key:

	sftp -i /home/.ssh/private_key user@host

## SFTP commands
once connected use the below commands to transfer files

``
get [file]   	#copy from sftp server to local machine
put [file] 		#copy from local machine to sftp server
mget *  		#copy multiple files from sftp using glob
mput *			#copy multiple files to sftp using glob
``

For more commands type or `man sftp`
	
