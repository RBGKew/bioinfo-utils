# i-want-a-jobby 

## Purpose
The jobs logging scripts provide a means to (non-interactively) list analyses that are running, or soon starting, on a given machine. The idea is to make it as simple as possible for people to use the system so there's no excuse!

It isn't interactive, e.g. you can't schedule or start/stop/cancel jobs, so it relies on an honesty-box type system, really.

It consists of three things:

 1. The jobs list itself, assumed to be `/etc/bioinfo.jobs.list`. This *must* be writeable by all users.
 2. The submission script, `i-want-a-jobby`. This can be anywhere (`/usr/bin` would be a good one though) and takes some simple commands to add a new line to the jobs log.
 3. Two profile scripts, `profile` and `zlogin`. These are placed in the relevant directories and make sure the last few jobs (10) in the jobs list are printed to users' shells each time they login.


## Usage
 The main i-want-a-jobby script will be called with
 ```i-want-a-jobby <program name> <start> <duration> <CPUs> <RAM>```
 Where:
	argv[0] (unsued, =='i-want-a-jobby')
	argv[1]: <program name>	Any text
	argv[2]: <start>	One of: 'now' 'yyyy-mm-dd' 'yyyy-mm-dd hh:mm'
	argv[3]: <duration>	Duration in hours/days/weeks (e.g. 3h, 1d, 0.5w etc)
	argv[4]: <threads>	(Optional) Number of threads
	argv[5]: <mem>	(Optional) Memory/RAM in Gb
	
## Note 
**assumes** the following:
 * /etc/bioinfo.jobs.list - the lobs list itself
 * /etc/profile - the global profile script run on login for all users
 * /etc/zsh/zlogin - profile script run on login for zsh users
 
## Credit/copyright
Joe Parker, 2016 / RBG Kew, 2016. 