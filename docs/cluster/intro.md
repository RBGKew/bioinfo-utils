
## Intro

We currently have a small (176 core) compute cluster, which can be used by anyone at Kew. It has a variety of bioinformatics and spatial analysis packages installed . To get access, or for general queries/software requests, please contact [James Crowe](mailto:james.crowe@kew.org) .

## Basics

### From Windows
Using putty, enter atta1 / atta2 into the hostname box

Enter "yes" or "y" if prompted

log in using your username and password

#### Transfering files (to home directory)

Use a trusted scp client, such as PSCP from the putty website

### From Linux/Mac
```
ssh username@atta1 / atta2
```
  enter password
#### Transferring files (to home directory):
```
scp path/to/file username@atta1:~/
```
## Queueing system
The cluster currently uses a standard install of slurm as a queuing system.
To submit a job, you'll need a script containing the command you want to run, and some instructions telling slurm what resources you need (how many cores, node specific software, etc)

Example:
```
#!/bin/sh
#SBATCH --ntasks=8
#SBATCH --workdir=/set/working/directory
#SBATCH--error=/path/to/error/files
#SBATCH--output=/path/to/standard/out
echo "hello world"

```
Currently, the only resource specification that works is ntasks, which specifies number of tasks to run.

### Submit a job:
```
sbatch name_of_a_bash_script
```
useful flags:

--workdir=/set/working/directory

--error=/path/to/error/files

--output=/path/to/standard/out

### Check job status:
```
squeue
```
or:
```
squeue -u username
```
to show only your jobs


## Tech specs
Runs Ubuntu 17

Two compute nodes, with:

* 4 x  Intel Xeon E7-8880 CPUs (22 cores per cpu)
* 1.5 TB RAM per node
* 500GB fast disk (mostly for operating system and installed progams)
* 42 TB attached scratch storage


## Rules
* Be considerate - the cluster is a shared resource. Please don't interfere with other people's jobs or data.
* Follow sensible security practices - don't share accounts, don't leave connections open to the cluster on shared computers, make sure you know that the data source you're using is safe.
* Report issues/ broken things
* Do not store data on the cluster. Please move it off when you are done. The cluster is not backed up, and your data may just vanish if too many discs fail.
