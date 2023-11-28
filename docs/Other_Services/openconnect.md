# Remote Access from Linux

in order to connect to VPN solutions from Linux you need to use openconnect version 9.12 or greater

## Installation
The following Disros have Version 9.12 or greater in their package manager:

Ubuntu 23.10 (and derivitives)

    sudo apt install openconnect

Arch (and derivitives)
    
    pacman -S openconnect 

For all other versions you'll need to install from the [openconnect website](http://www.infradead.org/openconnect/download.html) the compiled and installed following [these instructions](http://www.infradead.org/openconnect/building.html):
Install depenancies:
* Ubuntu/Debian: `sudo apt install libxml2 zlib openssl pkg-config`
* CentOS/RHEL/Fedora `sudo dnf install libxml2 zlib openssl pkgconf-pkg-config`

Download the [.tar.gz](https://www.infradead.org/openconnect/download/openconnect-9.12.tar.gz) from the infradead site. unpack the tar file, compile and install openconnect

    tar -zxf openconnect-9.12.tar.gz
    cd openconnect-9.12
    ./configure
    make
    sudo make install

  
## Connection
now that it's installed you can connect to the Kew VPN services with:

### DMZ VPN

    sudo openconnect  --protocol=pulse -u "AD/usr00kg" --server=dmzgate.dmz.kew.org
 
