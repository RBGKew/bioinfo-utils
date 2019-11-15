
## Intro

We currently have a small (2 x 176 core) compute cluster, which can be used by anyone at Kew. It has a variety of bioinformatics and spatial analysis packages installed . To get access, or for general queries/software requests, please contact [Raziel Lowe](mailto:r.lowe@kew.org).
To raise a ticket, please mail [support](mailto:support@kew.org) and copy in the [linux](mailto:linux@kew.org) team.

## Basics

### Overview

![Cluster Overview, http://www.kew.org](./cluster_overview.png)


### From Windows
Using putty, enter hatta.ad.kew.org into the hostname box

Enter "yes" or "y" if prompted

log in using your username and password

#### Transfering files (to home directory)

Use a trusted scp client, such as PSCP from the putty website

### From Linux/Mac
```
ssh username@hatta.ad.kew.org
```
  enter password
#### Transferring files (to home directory):
```
scp path/to/file username@hatta:~/
```
## Queueing system
The cluster currently uses a standard install of slurm as a queuing system.
There are five queues at this time as follows, please note jobs that run after the time on the queue will be stopped by the system.:--

  fast    :-- Allows jobs to be run for up to 1 day.
  main*   :-- Allows jobs to be run for up to 3 days.
  medium  :-- Allows jobs to be run for up to 7 days.
  long    :-- Allows jobs to be run for up to 14 days.
  dungeon :-- Allows jobs to be run for up to 28 days.
  
  ( * = this denotes the default queue jobs will be placed in if none is defined in script )
  
To submit a job, you'll need a script containing the command you want to run, and some instructions telling slurm what resources you need (how many cores, node specific software, etc.)

Example (Run a job with 5 cores):
```
#!/bin/bash
#
#SBATCH --job-name=test_omp
#SBATCH --output=res_omp.txt
#
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
echo "hello world!"
```
Example 2 (Run a job with 10 cores, on the Long Job Queue)
```
#!/bin/bash
#
#SBATCH --job-name=test_omp
#SBATCH --error=error.txt
#SBATCH --error=out.txt
#
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --partition=long
echo "hello world!"
```


### Submit a job:
```
sbatch name_of_a_bash_script
```
useful flags:

--workdir=/set/working/directory

--error=/path/to/error/files

--output=/path/to/standard/out

--time=10:00  sets the maximum time for a job to 10 minutes - useful for jobs that can otherwise run for ever.

### Check job status:
```
squeue
```
or:
```
squeue -u username
```
to show only your jobs

### Kill a job
Get the job id from 
```
squeue -u username
```
Then
```
scancel jobid
```

## Tech specs
Runs Ubuntu 17

Two compute nodes, with:

* 4 x  Intel Xeon E7-8880 CPUs (22 cores per cpu)
* 1.5 TB RAM per node
* 500GB fast disk (mostly for operating system and installed progams)
* 42 TB attached scratch storage, shared between nodes


## Rules
* Be considerate - the cluster is a shared resource. Please don't interfere with other people's jobs or data. Compute power is limited, please don't fill the entire cluster with your jobs
* Follow sensible security practices - don't share accounts, don't leave connections open to the cluster on shared computers, make sure you know that the data source you're using is safe.
* Report issues/ broken things
* Do not store data on the cluster. Please move it off when you are done. The cluster is not backed up, and your data may just vanish if too many discs fail.
