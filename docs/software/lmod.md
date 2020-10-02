#Lmod
Lmod is an environment variable management software used to load and unload specific versions of software from with in your scripts

On KewHPC all software is installed as an lmod module.

##using Lmod
To see which modules are available:

	module available 

To load a module:

	module load blast/2.10 

To unload a module

	module unload blast/2.10

##an example slurm script
lmod allows you to use multiple versions of software in the same script

	#!/bin/bash 
	#SBATCH -c 1
	#SBATCH -p all
	#SBATCH -J test_job
	#SBATCH -t 0-3:00:00
	#SBATCH -o /data/users_area/myname/test.log
	
	module load python/2.7.18

	python ./python2.7-script.py 

	module unload python/2.7.18
	module load python/3.7.9

	python ./python3.7-script.py 


 