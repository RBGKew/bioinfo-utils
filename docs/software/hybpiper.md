# HybPiper

HybPiper has been centrally installed on the cluster using a wrapper script, this slightly changes how it operates.
loading the module loads all of the dependencies

	module load hybpiper/1.3.1

## Usage Example 
This is a basic template of how to run reads first in a bash script on KewHPC

	#!/bin/bash
	#SBATCH -j hybpiper_example
	#SBATCH -e /data/users_area/myuser/errout/hybpiper_%A.err
	#SBATCH -o /data/users_area/myuser/errout/hybpiper_%A.out
	#SBATCH -c 8 
	#SBATCH -p all

	module load hybpiper/1.3.1

	name="miseq_run_GTCATA_L001"
	hybpiper reads_first	--cpu 8 \
							-b /data/users_area/myuser/baitfile.fasta \
							-r /data/users_area/myuser/$name\_R*.fastq \
							--unpaired /data/users_area/myuser/$name.fastq \
							--prefix seqdata \
							--cov_cutoff 4 
	hybpiper cleanup $name
