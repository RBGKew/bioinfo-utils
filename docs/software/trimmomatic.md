# Trimmomatic

Trimmomatic has been centrally installed on the cluster using a wrapper script, this slightly changes how it operates.
loading the module loads all of the dependencies

	module load trimmomatic/0.39

## Usage Example 
This is a basic template of how to run reads first in a bash script on KewHPC

	#!/bin/bash
	#SBATCH -J trimmomatic_example
	#SBATCH -e /data/users_area/myuser/errout/trimmomaticr_%A.err
	#SBATCH -o /data/users_area/myuser/errout/trimmomatic_%A.out
	#SBATCH -c 8 
	#SBATCH -p all

	module load trimmomatic/0.39

	trimmomatic PE -threads 8 -phred64 -basein infile1 infile2 -baseout outfile
