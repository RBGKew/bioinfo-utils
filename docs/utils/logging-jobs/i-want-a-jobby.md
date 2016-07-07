# i-want-a-jobby 

## Purpose
Python script to add jobs to the /etc/bioinfo.jobs.list. More info [here](index.md).

## Usage
Will be called with:

```
i-want-a-jobby <program name> <start> <duration> <CPUs> <RAM>
	<program name>	Any text
	<start>	One of: 'now' 'yyyy-mm-dd' 'yyyy-mm-dd hh:mm'
	<duration>	Duration in hours/days/weeks (e.g. 3h, 1d, 0.5w etc)
	<threads>	(Optional) Number of threads
	<mem>	(Optional) Memory/RAM in Gb
```
	
## Note 
**assumes** the following:

* `/etc/bioinfo.jobs.list` - the lobs list itself
* `/etc/profile` - the global profile script run on login for all users
* `/etc/zsh/zlogin` - profile script run on login for zsh users
 
## Credit/copyright
Joe Parker, 2016 / RBG Kew, 2016. 