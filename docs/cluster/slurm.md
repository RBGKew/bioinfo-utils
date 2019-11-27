# Using the SLURM workload manager

SLURM (Simple Linux Utility for Resource Management) is a workload mangement system for scheduling jobs 

# Submitting Jobs

In order to take advantage of the computational power of teh cluster you'll need to submit your jobs using slurm.

**Resourse intensive scripts should not be run on the head/login node.** If you want to see what your script is doing please submit an interactive job (see below)

## partitions - Where to queue your job

Partitions are the various queues which jobs can be submitted to.

On hatta the partitions are as follows:

name | time limit | nodes | relative priority*
---- | ---------- | ----- | ------------------
fast| 1 day | 1, 2 & 3 | 8000 
main| 3 days | 1, 2 & 3 | 7000 
medium| 1 week | 1, 2 & 3 | 6000  
long| 2 weeks | 1, 2 & 3 | 4000 
dungeon| 3.4 weeks | 1, 2 & 3 | 2000 

\*The way job resource allocation is prioritised is based on multiple factors, not just queue.

If a Job hots the Partition time limit it will be killed (presumed crashed) so bare this in mind if you're job length is varaiable or doesn't seem to have completed correctly.

This system works best if you submit your job to the partition with the shortest time limit your job will finish comfortably in. 

## sbatch - How to submit your job
Jobs are submited to the cluster using the sbatch command. For example:

	sbatch -c 1 -p main -J test_job -t 0-3:00:00 -o /data/users_area/myname/test.log script.sh

The slurm script (in this case script.sh)  can also have a header containing the same peramiters, particulary useful for frequenly run jobs:

	#!/bin/bash 
	#SBATCH -c 1
	#SBATCH -p main
	#SBATCH -J test_job
	#SBATCH -t 0-3:00:00
	#SBATCH -o /data/users_area/myname/test.log
	echo "hello world!"

list of useful sbatch arguments:

With the header the script can be submitted :

	sbatch script.sh


Argument | long Argument | Value | Comment
-------- | ------------- | ----- | -------
-a|--array| | 
-c|--cpus-per-task|1-88| number of CPU cores needed per job
-D|--chdir|/working/dir| makes the script run i the specified directory
-e|--error|/dir/to/std.err| give a file for your jobs STDERR output to be piped into (for STDOUT see -o)
-J|--job-name|"job_name"| gives your job a name 
-N|--nodes|min[-max]| give the number of nodes (or a range of numbers of nodes) you want your job to run accross
-o|--output|/dir/to/std.out| give a file for your jobs STDOUT to be piped into (for STDERR see -e)
-p|--partition|partition name| select witch partition to submid your job to (listed above; default is "main") 
-Q|--quiet ||quiet mode (won't print to STDOUT)
-t|--time|time in minuets| set a time limit for your job
 |--mail-user|your.email@kew.org| an email adde to be notafied of the job's status
 |--mail-type|BEGIN END FAIL ALL| which events you want to be emailed about

## submitting an interactive job

Submitting an interactive job can be useful when developing and testing your code. 

	srun -pty bash -i 

This will put you on to one of the work nodes of the cluster. Just remember to **exit** when your done!

# Monitoring your Jobs and the cluster

There are a few tools to look at what's going on on the cluster.

## sinfo - see the status of the partitions

## squeue 

shows submitted jobs in the queue and their status

	squeue

Argument | long argument | value | comment
-------- | ------------- | ----- | ------
-u|--user| your username | only show your jobs
## sacct

## scontol

## sview

# Cancelling Jobs

If you want to cancel a job either before it runs or while it is running you can use scancel

	scancel jobid


Argument| long Argument |Value|Comment
-a|--array| | 

