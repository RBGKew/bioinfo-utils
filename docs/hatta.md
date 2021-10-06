# HATTA

*Due to an attached storage failure hatta is offline indefinitely*


HATTA is a small (3 node, 192 core) compute cluster, for the use of Kew Scientists. It has a variety of bioinformatics and spatial analysis packages installed. To get access, or for general queries/software requests, please contact [Matt Clarke](mailto:m.clarke@kew.org).

## Tech specs
hatta runs on Ubuntu 18.04 LTS with a total of 192 cores and 3.0 TB RAM a cross 3 nodes

Compute nodes 1 & 2, each with:

* 4 x 22 core Intel Xeon CPU @ 2.20-3.00GHz
* 1.0 TB RAM

Compute node 3 with:

* 2 x 8 core Intel Xeon CPU @ 3.20-3.60GHz
* 1.0 TB RAM

## Quick start Guide
To get access to both hatta and KewHPC contact [Matt Clarke](mailto:m.clarke@kew.org)

Once you have access you can:

### Log in
#### From Windows
Using [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) in the main window enter:

	Host: hatta
	User: yourkewuser
    Port: 22

Enter "yes" or "y" if asked to confirm adding hatta to hosts list.

Log in using your Kew password when prompted

#### From MacOS / Linux

Open a terminal window and type:

	ssh username@hatta

Type "yes" if prompted to confirm adding hatta to your hosts list

Enter your password.

### Transfer Data
#### From Windows
Using an SFTP client such as [FileZilla](https://filezilla-project.org/download.php?platform=win64)

In Filezilla use the Quickconnect bar or Site Manager and enter:

	Host: sftp://hatta 
	Username: your Kew username
	Password: your Kew password
	Port: 22 
 
#### From MacOS / Linux
[FileZilla](https://filezilla-project.org) works the same on as on Windows but for larger files or whole directories you can use rsync via the terminal.

Copying to hatta:

	rsync -avP /local/file/or/directory username@hatta://directory/to/copy/to

Copying from hatta:

	rsync -avP username@hatta://file/or/directory/to/copy /local/destination/for/files

If you want to copy a directories contents and not the directory itself add a trailing "/" to the first argument.
If the rsync command is interrupted just re-run the exact command and its should continue from the file it was last transferring.

### Submit Jobs
HATTA uses slurm to manage job submissions
to submit jobs you need to create a submission script
for example test_script.sh: 

	#!/bin/bash 
	#SBATCH -c 1
	#SBATCH -p main
	#SBATCH -J test_job
	#SBATCH -t 0-3:00:00
	#SBATCH -o /data/users_area/myname/test.log
	echo "hello world!"

you submit the job using the command:

	sbatch test_script.sh

you can see the jobs currently running by using the command 

	squeue

For more details see [this page](./software/slurm.md) or the [slurm documentation](https://slurm.schedmd.com/)
## Data Storage
There are 3 main places you can store your data /home, /data and /science.

For access to a project groups and directories you need to contact [Matt Clarke](mailto:m.clarke@kew.org) and get permission form the groups owner (usually the associated team leader).

### /home 
Your Home directory is the place you'll land when you login. This is a god place to save your scripts and some configuration files. It is Limited to 4GB so it's best not to store any data or programs here.
### /data
This is the cluster attached storage, Its fast and the best place to store the data you're currently analysing. There are 2 main areas /data/projects for shared data and analysis /data/users_area for single user data and analysis.
### /science
This is the slower, longer term storage for your data. Its attached to both HATTA and KewHPC allowing data to be accessed by both machines. Please move any data stored here to a directory in /data before running analysis. There are /science/projects and /science/users_area directories as in /data

## Installed Software

| Name | Version |
| :------ | ------: |
| ABySS | 2.2.3 |
| angsd | 0.930 |
| ASTRAL | 5.6.3 |
| ASTRAL (MP) | 5.14.2 (broken)|
| blast | 2.6.0 |
| bowtie | 1.2.2 |
| bowtie2 | 2.3.4.1 |
| Bracken | 2.5 |
| BWA | 0.7.17-r1188 |
| Clustal Omega | 1.2.4 |
| EMBOSS | 6.6.0.0 |
| embassy-phylip | 3.69.660-2 |
| exonerate | 2.4.0 | 
| FastQC | 0.11.5 |
| FastTree | 2.1.10 |
| FastTreeMP | 2.1.11 |
| FineRADstructure | git master 2020-01-29 |
| GemonmeMapper | 0.4.4s |
| GNU Parallel | 20161222 |
| HybPiper | N/A [more info](./software/hybpiper.md) |
| IQ-TREE | 1.6.12\|2.0-rc |
| Kraken2 | 2.0.8-beta |
| Krona Tools | 2.7.1 |
| LaTeX (pdfTeX) | 3.14159265-2.6-1.40.18 |
| MAAFT | 7.310 |
| MEGAHIT | 1.2.9 |
| MUSCLE | 3.8.31 |
| mariadb | 15.1 |
| Newick-utils | 1.6 |
| Perl | 5.26.1 |
| phyx | (broken) |
| pmerge | 1.0 |
| Python | 2.7.17 |
| Python3 | 3.6.9 |
| QUAST | 5.0.2 |
| R | 3.6.1 |
| RAxML-NG (MPI) | 0.9.0 |
| RAxML (MPI) | 8.2.11 |
| RepeatExplorer2 | |
| RevBayes | 1.1.0 | 
| samtools | 1.7 | 
| seqtk | 1.3-r106 |
| Slurm | 0.4.3 |
| SPAdes | 3.11.1 |
| SRA toolkit | 2.10.2 |
| Stacks | v2.0Beta8c+dfsg\|2.41 |
| structure | 2.3.4 |
| treepl | (broken?) |
| treeshrink | 1.3.4 |
| trimAL | 1.2rev59 |
| trimomatic | (broken?) |
| VCFtools | 0.1.16 |
