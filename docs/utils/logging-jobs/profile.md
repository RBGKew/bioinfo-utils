# profile

## Purpose
Additional profile command (`tail /etc/bioinfo.jobs.list`) run on login to print out the bioinfo.jobs.list, which should contain upcoming jobs for this machine.

## Usage
Add lines in this file to /etc/profile - should run each time a user logs in (possibly not for zsh).

## Note 
**assumes** the following are all visible:
 * /etc/bioinfo.jobs.list - the lobs list itself, must also be writeable
 * /etc/profile - the global profile script run on login for all users
 * /etc/zsh/zlogin - profile script run on login for zsh users
 * /usr/bin/i-want-a-jobby - the script to add users' jobs to the list
 
 ## Credit/copyright
 Joe Parker, 2016 / RBG Kew, 2016. 