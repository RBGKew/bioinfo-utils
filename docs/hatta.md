# About HATTA
HATTA is a small (3 node, 192 core) compute cluster, which can be used by anyone at Kew. It has a variety of bioinformatics and spatial analysis packages installed. To get access, or for general queries/software requests, please contact [Matt Clarke](mailto:m.clarke@kew.org).

## System Overview
![Cluster Overview] (./images/hatta_overview.png)

## Tech specs
Runs Ubuntu 18.04 LTS

Total 192 cores and 3.0 TB RAM a cross 3 nodes
Compute nodes 1 & 2, each with:

* 4 x 22 core Intel Xeon CPU @ 2.20-3.00GHz
* 1.0 TB RAM

Compute node 3 with:

* 2 x 8 core Intel Xeon CPU @ 3.20-3.60GHz
* 1.0 TB RAM

# Quick start Guide
To get access to the bioinformatic resources contact [Matt Clarke](mailto:m.clarke@kew.org)

Once you have access you can:

## Log in
### From Windows
Using [PuTTY](https://putty.org), enter hatta into the hostname box

Enter "yes" or "y" if asked to confirm adding hatta to hosts list.

log in using your username and password

### From MacOS / Linux

open a terminal window and type

	ssh username@hatta

Type "yes" if prompted to confirm adding hatta to your hosts list

enter your password.

## Transfer Data
### From Windows
using an SFTP client such as [FileZilla](https://filezilla-project.org/download.php?platform=win64)

In Filezilla use the Quickconnect bar:
Host: sftp://hatta 
Username: your Kew username
Password: your Kew password
Port: 22 
 
### From MacOS / Linux
[FileZilla](https://filezilla-project.org) also works the same on Linux and Mac.

For larger files or many files you can use rsync via the terminal
Copying to hatta:

	rsync -avP /local/file/or/directory username@hatta://directory/to/copy/to

Copying from hatta:

	rsync -avP username@hatta://file/or/directory/to/copy /local/destination/for/files

If you want to copy a directories contents and not the directory itself add a trailing "/" to the first argument.
If the rsync command is interupted just re-run the exact command and its should continue from the file it was last transfering.

## Submit Jobs
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

For more details see [this page](./software/slurm.md) or the [slurm documenation](https://slurm.schedmd.com/)
# Data Storage
There are 3 main areas where you can store data

## /home
Your home directory is the place you'll land when you login.
this is a good place to save your scripts and some configuration files.
It is limited to 4GB per user so it's best not to store any data or programs here.

## /data
This is the cluster attached storage, Its fast and the best place to store the data your currently analysing
there are 2 main areas /data/projects for shared data and analysis /data/users_area for single user data and analysis.

If you require a new group or access to a current one contact [Matt Clarke](mailto:m.clarke@kew.org)
## /science
This is the slower, longer term sorage for your data. Its attached to both HATTA and KewHPC allowing datta to be accessed by both machines.
Please move any data stored here to a directory in /data before running analysis
there are /science/projects and /science/users_area directories as in /data

# Installed Software

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

