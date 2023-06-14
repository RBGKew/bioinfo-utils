
### Submit Jobs
KewHPC uses slurm to manage job submissions
to submit jobs you need to create a submission script
for example test_script.sh: 

	#!/bin/bash 
	#SBATCH -c 1
	#SBATCH -p all
	#SBATCH -J test_job
	#SBATCH -t 0-3:00:00
	#SBATCH -o /data/users_area/myname/test.log
	echo "hello world!"

you submit the job using the command:

	sbatch test_script.sh

you can see the jobs currently running by using the command 

	squeue

For more details see [this page](./software/slurm.md) or the [slurm documentation](https://slurm.schedmd.com/)

