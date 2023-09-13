### Connecting To KewKPC
Connection to KewHPC handled by SSH (Secure SHell) command line interface, using your Kew IT accounts credentials to login. To have your Kew account activated for you on KewHPC please contact [Matt Clarke] (mailto:m.clarke@kew.org). Your user name will be in the format of 2/3 letters 2 numbers then kg (usr00kg is used as an example in this documentation) and your password will be the same as the one you use for logging into Kew computers, email, and other services. KewHPC is only accessable from within the Kew network, so If your not on site at either Kew or Wakehurst you'll need to use One of the VPN soulutions provided by Kew.

#### At A glance
If you're familliar with SSH here's the information you need:

    host: kewhpc.ad.kew.org
    host aliases: kewhpc, kpphpclogin01.dmz.kew.org

    port: 22
    username: your kew user name (e.g. usr00kg)
    password: your kew password

If you are new to SSH or need to set up an SSH client keep reading.


#### SSH On MacOS and Linux

You'll need to have an SSH client installed on the machine you intend to use to access KewHPC. 


On MacOS and all commmon linux distributions this is pre-installed. You can access this by opening a terminal window and typing the command:


    ssh usr00kg@kewhpc.ad.kew.org

Replace "usr00kg" with your kew username

If connecting for the first time on you'll then be asked to verify the authenticityof the server (KewHPC). If the fingerprint given matches this one `SHA256:YJNuet435XWBK1JQpZEJ3+u9d7M7MkKYbmTc1ogUVPg` confrim by  typing `yes` and then your password when prompted. If the fingerprint doesn't match contact [Matt Clarke](mailto:m.clarke@kew.org) or [IT service desk](mailto:support@kew.org) as your connection to KewHPC may not be secure.


#### SSH On Windows

Unlike MacOS and Linux, Windows dowsn't come with an SSH client by default. Kew issued computers do usually have PuTTY preinstalled. If no client is present you'll need to install on of either [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) or [MobaXterm](https://mobaxterm.mobatek.net/download.html) .

***PuTTY***
![PuTTY](images/putty.jpg)
On opening putty you'll see this window. enter the host `kewhpc.ad.kew.org` and check that the port is `22` then click open. If connecting for the first time on you'll get a Security Alert Popup. If the fingerprint given matches this one `SHA256:YJNuet435XWBK1JQpZEJ3+u9d7M7MkKYbmTc1ogUVPg` confrim by clicking `yes` and then your username and password when prompted. If the fingerprint doesn't match contact [Matt Clarke](mailto:m.clarke@kew.org) or [IT service desk](mailto:support@kew.org) as your connection to KewHPC may not be secure.

***MobaXterm***
![mobaxterm](images/mobaxterm.jpg)
On opening MobaXterm click on `Session` and then `SSH` in the new window. You should now see the fields in the image above. Fill in the remote host `kewhpc.ad.kew.org`, your username and check that the port is `22`. If connecting for the first time on you'll then be asked to verify the authenticityof the server (KewHPC). If the fingerprint given matches this one `SHA256:YJNuet435XWBK1JQpZEJ3+u9d7M7MkKYbmTc1ogUVPg` confrim by  typing `yes` and then your password when prompted. If the fingerprint doesn't match contact [Matt Clarke](mailto:m.clarke@kew.org) or [IT service desk](mailto:support@kew.org) as your connection to KewHPC may not be secure.

#### GUI applications 

Some applications on KewHPC have a GUI which can be displaied remotly using X11 forwarding. On MacOS and linux just add `-X` to you ssh command to enable.

    ssh -X usr00kg@kewhpc.ad.kew.org

For PuTTY and MobaXterm  select the check box for X11 forwarding the the Advanced options.


#### Troubleshooting

**While at Kew/Wakehurst I get the error: "ssh: Could not resolve hostname"** Check which wifi you're connected to. Eduroam and Visitor wifi don't have access to the kew network. At some locations none of the WiFi options allow KewHPC access, a work around is to connect to eduroam and then use one of the Kew VPN solutions, as if you were off site.

**While offsite I get the error "ssh: Could not resolve hostname"** Check that your VPN is properly connected or try an different host alias ("kewhpc" doesn't work while connected to the DMZ VPN)

If you're still having connection issues contact [Matt Clarke](m.clarke@kew.org).
