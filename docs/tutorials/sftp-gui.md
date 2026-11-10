# SFTP with Filezilla

Filezilla is a SFTP client available for all platforms and should be installed on  Kew Laptops by default. 

If not installed download from [here](https://filezilla-project.org/download.php?platform=win64)

## Set up Connection
This will save the connection so you just have to select the server on the site manager dropdown.

Open site manager (top left button or file > site manager or Ctrl+S)
![picture with numbered highlights]

1. click `new site`
2. select `SFTP-SSH FILE Transfer Protocol`
3. type in host you want to connect to
4. Port should be 22 unless otherwise stated

![Picture with number highlights]

### Password login
1. select Ask for password
2. Fill in your username and password for the server 
3. Click OK

![Picture with number highlights]

### Key Pair authentication
After generating your key pair and sending the public key to the servers admin:
1. select Key file
2. Fill in your username for the server
3. Click `Browse...` to navigate to your generated *Private* key file and `open`
4. Click OK

![Picture with number highlights]

## Connect
Once saved you can just connect by selecting your saved site(server) from the sitemanager dropdown menu

![Picture with number highlights]
