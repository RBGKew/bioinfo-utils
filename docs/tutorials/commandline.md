# The Linux Command Line
The Command line is a text based mathod if interacting with a computer as aposed to the Grapgical interfaces such as Windows Explorer or MacOS Finder.

Once you open a command line interface (Terminal on your local computer or ssh into a server such as the Crop Diversity HPC) your presented with the command prompt which will look something like this:

    usernmame@computername:~$

In the examples on this page this will be represented with just a singel `$` at the begining of lines where a command has been typed. Lines with out this are the output of the above command


## Moving around the files system
Linux file paths are shown as a series of directory (folder) names separate by `/` like this:

    /home/username/

The collection of many directories for a file system are refered to as the directory tree with the first `/` beeing the root and subsequent directories being branches

### To find out your loacation on the directory tree use the command `pwd`

```bash
$ pwd
/home/username
```

### To change the directory your in use `cd`

```bash
$ cd /home/username/myproject
```
There isnt any output for this command, but your location in the command prompt will have changed

### To see the contents of a diractory use `ls`

```bash
$ ls /home/username/myproject
myfile  myotherfile
```
