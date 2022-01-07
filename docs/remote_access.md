# Remote Access

To use Kew's Computational resources remotly you'll need to connect to one of the below VPN services


## KewVPN 

Kew Provides 2 VPN services for Kew staff to connect to Kew services remotely from their Kew issued laptop.

For access to either you'll need to contact [IT services](mailto:support@kew.org)

### PulseSecure
Using any web browser go to [backgate.kew.org](https://backgate.kew.org) and log in with your kew username and password, with the realm as "AD".

Once logged in Click the "start" button.

![Client Application Sessions > Pulse Secure > Start](PulseSecure1.jpg)

Then hit the download button, save and install the Pulse Secure client.

![Download > Save > Run PulseSecureAppLauncher.msi](PulseSecure2.jpg)

Once Pulsesecure is installed open pulse secure if its not already then add a new connection ("+" or File > Connections > Add)

![File > Connections > Add](PulseSecure3.jpg)

In the new window name your connection and set the server URL to backgate.kew.org and click "Connect".

![backgate.kew.org](PulseSecure4.jpg)

Select the Realm "AD" and enter your user name and password when prompted


*There are limited simultanious licences for the Pulse Secure VPN so if you get an error saying it's at capacity try one of the other methods. For the same reason you should log out as soon as you're done to allow others to login.*

### GlobalProtect

using any web browser go to [kvpn1.kew.org](https://kvpn1.kew.org) and log in with your kew username and password.

Once logged in click the link for your Operating System, Download and Install the Global Protect Client. Then enter the Portal name kvpn1.kew.org

![kvpn1.kew.org](GlobalProtect1.jpg)

The enter your Kew username and password and "Sign In".

![Your username and password please](GlobalProtect2.jpg)


## KewHPC DMZ VPN

This is a VPN service specifically for connecting to KewHPC for both Kewstaff and external colaboratores. It uses Pulse secure so if you already have the PulseSecure Cient installed skip to the last step.

using any web browser go to [dmzgate.kew.org](https://dmzgate.kew.org) and log in with your kew username prefixed with "AD\" (e.g. AD\usr00kg ) and password.

Once logged in Click the "start" button.

![Client Application Sessions > Pulse Secure > Start](PulseSecureDMZ1.jpg)

Then hit the download button, save and install the Pulse Secure client.

![Download > Save > Run PulseSecureAppLauncher.msi](PulseSecure2.jpg)

Once Pulsesecure is installed open pulse secure if its not already then add a new connection ("+" or File > Connections > Add)

![File > Connections > Add](PulseSecure3.jpg)

In the new window name your connection and set the server URL to dmzgate.kew.org and click "Connect".

![dmzgate.kew.org](PulseSecureDMZ2.jpg)

Select the Realm "AD" and enter your user name and password when prompted


*There are limited simultanious licences for the Pulse Secure VPN so if you get an error saying it's at capacity try one of the other methods. For the same reason you should log out as soon as you're done to allow others to login.*


## Setting up colaborators to work on KewHPC
