#SLURM

SLURM (Simple Linux Utility for Resource Management) is a workload management system for scheduling jobs

#Submitting Jobs

In order to take advantage of the computational power of the cluster you'll need to submit your jobs using slurm.

## Batch Job Submission - sbatch

Most Jobs on the cluster are submitted using batch scripts. They can be a simple bash script:

	#!/bin/bash
	echo "hello world"

submitted with command line arguments to sbatch

	sbatch -c 1 -p main -J test_job -t 0-3:00:00 -o /data/users_area/myname/test.log script.sh

or can have arguments incorporated in to the script header (recommended if the script is to be run multiple times)

	#!/bin/bash 
	#SBATCH -c 1
	#SBATCH -p all
	#SBATCH -J test_job
	#SBATCH -t 0-3:00:00
	#SBATCH -o /data/users_area/myname/test.log
	echo "hello world!"

and submitted simply:

	sbatch script.sh

here is a list of some recommended arguments which can be used on both the command line and in the batch script

|Argument | long Argument | Example Value | Comment |
|:-------- | ------------- | ------------- | ------- |
|-a|--array| 0-6,8,10 | see "Array Jobs" below | 
|-c|--cpus-per-task | 2 | number of CPU needed usually matched to max number of threads used by the program |
|-D|--chdir| /working/dir | makes the script run i the specified directory |
|-e|--error| /dir/to/std.err| give a file for your jobs STDERR output to be piped into (for STDOUT see -o) |
|-J|--job-name| "job_name"| gives your job a name |
|-n|--ntasks | 3 | this is for multiprocess jobs. multiplies with --cpus-per-task |
|-N|--nodes| 1-3 | give the number of nodes (or a minimum and maximum number of nodes) you want your job to run across |
|-o|--output| /dir/to/std.out | give a file for your jobs STDOUT to be piped into (for STDERR see -e) |
|-p|--partition| partition name | select witch partition to submit your job to ( see "Partitions" below ) |
|-Q|--quiet || quiet mode (won't print to STDOUT) |
|-t|--time| time in minuets | set a time limit for your job |

### Array Jobs 

Array jobs can be used to submit many jobs with similar tasks

The example here runs analysis on either a list of input files in a text file or file:

	#!/bin/bash 
	#SBATCH -c 1
	#SBATCH -p all
	#SBATCH -J array_test_%A_%a
	#SBATCH -t 0-3:00:00
	#SBATCH -a 0-6,8,10%3
	#SBATCH -o /data/users_area/myname/arraytest_%A_%a.out
	#SBATCH -e /data/users_area/myname/arraytest_%A_%a.err
	
	#from text file
	inputfiles=( $( cat ./list_of_inputfiles.txt ) )

	#uncomment to analyse all *.fq.gz files in directory
	#inputfiles=( $( ls /data/users_area/usr00kg/input_files | grep *.fq.gz ) )

	analysis_program --input=/data/usersarea/usr00kg/input_files/${inputfiles[$SLURM_ARRAY_TASK_ID]} --output=/data/usersarea/usr00kg/output_files/${inputfiles[$SLURM_ARRAY_TASK_ID]}_analysis.txt

The #SBATCH -a 0-6,8,10%3 line mean that array elements 0,12,3,4,5,6,8 and 10 will be run maximum 3 at a time (%3)
elsewhere in the script %A is used to show the Jobid of the array job and %a is the numbered element of the array

the numbered element of the array can be accessed in the bash script using the variable $SLURM_ARRAY_TASK_ID

There are many other Slurm variables available for use in scripts as seen [here](https://slurm.schedmd.com/sbatch.html#lbAK) 

## Interactive Job submission - salloc, srun

It is possible to log in to node interactively. This can be useful for testing

in slurm you need to request a node:

	salloc --ntasks=1 --time=00:05:00

this will allocate a job ID. then srun can be used to start a login shell on that node:

	srun --jobid=000000 --pty /bin/bash

remember to use scancel to end the session when finished.

## Monitoring Jobs - squeue, sacct

To show a list of the jobs currently queued and running on the cluster:

	squeue

If you can't find your job on squeue it's likely already finished (or failed). 

To see all of the jobs you've submitted with their state and exit code:

	sacct

## Cancelling Jobs - scancel

If you want to cancel a job either before it runs or while it is running you can use scancel

	scancel jobid

## Partitions - sinfo

Partitions are the different queues you can submit jobs too
The key differences are the time limits and priority, short jobs will wait less time in the queue when the cluster is busy but must complete within 24hrs
If unsure just use the default of all for KewHPC and main for HATTA and change if needed.
To see the active partition list use:

	sinfo

### KewHPC

Name | Time Limit | nodes | relative priority | Default
---- | ---------- | ----- | ----------------- | ------
short | 1 day | nodes 1-12 | 5 |  |
all | 3 days | nodes 1-12, hmem 1-2 | 3 | Yes |
long | 30 days | nodes 1-12 | 1 |  |
hmem | 14 days | hmem 1-2 | 6 |  |

### HATTA

Name | Time Limit | Nodes | Relative Priority | Default
---- | ---------- | ----- | ----------------- | -------
fast| 1 day | 1, 2 & 3 | 8000 | |
main| 3 days | 1, 2 & 3 | 7000 | Yes |
medium| 1 week | 1, 2 & 3 | 6000 |  |
long| 2 weeks | 1, 2 & 3 | 4000 | |
dungeon| 3.4 weeks | 1, 2 & 3 | 2000 | |

## Fairshare Policies

In order to allow all users access to the cluster a set of fair use policies are set in slurm on KewHPC.

As a user submits jobs their users priority factor starts to drop so that another users jobs will take priority. This prevents a single user filling the cluster with jobs blocking other users

If your job is waiting in the queue for a long time it could be that:

- you've submitted a lot of jobs recently and your priority factor has been temporarily lowered
- you're asking for a lot of resources per job reducing your priority factor.
	- try reducing the required number of cores per job
- you've submitted to a low priority partition (long/dungeon)
	- submit to a higher priority partition if time restrictions allow

If this isn't the case please contact [Matt Clarke](mailto:m.clarke@kew.org)

