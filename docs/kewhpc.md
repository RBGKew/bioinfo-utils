# KewHPC

Kew HPC is our main compute cluster with 576 cores across 14 nodes.

It has a variety of bioinformatic analysis packages installed. To get access, or for general queries/software requests, please contact [Matt Clarke](mailto:m.clarke@kew.org).

## Technical Specifications
KewHPC runs on CentOS 7.7 with a total of 576 cores and 7.6TB RAM across 14 nodes

12x Compute nodes with:

* 2 x18 core Intel Xeon CPU @ 2.6GHz
* 384 GB RAM

2 x High Memory nodes with:

* 4 x 18  core Intel Xeon CPU @ 2.6GHz
* 1.5 TB RAM

## Quick Start Guide
To get access to the bioinformatic resources contact [Matt Clarke](mailto:m.clarke@kew.org)

From within Kews network you can simply connect using the instructions below. If you need remote access follow [this](./remote_access.md) guide

### Log in
#### From Windows
First install and open [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
Then in the PuTTY Configureation Window:

fill in the "Host Name (or IP address)" box with:

	kewhpc

And under "Port" make sure it says:

	22
 
Then click "Open"

You'll then be shown a "PuTTY Security Alert" to which you click "Accept"

Then enter your Kew username and password when prompted.

#### From MacOS / Linux

open a terminal window and type

	ssh username@KewHPC

Type "yes" if prompted to confirm adding hatta to your hosts listperfomace

enter your password.

### Transfer Data
#### From Windows
Using an SFTP client such as [FileZilla](https://filezilla-project.org/download.php?platform=win64)

In Filezilla use the Quickconnect bar or Site Manager and enter:

	Host: sftp://kewhpc
	Username: yourkewusername
	Password: yourkewpassword
	Port: 22 

#### From MacOS / Linux
[FileZilla](https://filezilla-project.org) works the same on as on Windows but for larger files or whole directories you can use rsync via the terminal.

Copying to kewhpc:

	rsync -avP /local/file/or/directory username@kewhpc://directory/to/copy/to

Copying from kewhpc:

	rsync -avP username@kewhpc://file/or/directory/to/copy /local/destination/for/files

If you want to copy a directories contents and not the directory itself add a trailing "/" to the first argument.
If the rsync command is interrupted just re-run the exact command and its should continue from the file it was last transferring.

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

## Data Storage
There are 3 main places you can store your data /home, /data and /science.

| Location | Size | Speed | Usage | Availability | Redundancy |
|----------|------|-------|-------|--------------|-------------|
| /home | 10GB per user | Fast | Config files, scripts and documents | login01, node001-012, hmem01-02 | Not backed up, keep a copy of scripts on your local machine or on /science |
| /data | 340TB Total | Fast | Data and scripts for jobs running on KewHPC | login01, node001-012, hmem01-02 | Not backed up, keep a copy of irreplaceable data on /science |
| /science | 139TB Total | Slower | Data and scripts not currently in use, but which need keeping accessible | login01 | Snap-shotted with a mirror at the Wakehurst site |

There are 2 main areas in /data and /science.

### projects
For data shared for a specific project. 
To access an existing group or to request a new project directory and group you need to contact [Matt Clarke](mailto:m.clarke@kew.org) and get permission form the groups owner (usually the associated team leader).

### users_area
A place for an individual user to run analyses (in the case of /data/users_area) and store data only needed by them.

## Installed Software

Software is installed using lmod see [this page](./software/lmod.md) to load and unload different software

| Name | Version |
| :------ | ------: |
| amas | 1.0 |
| astral | 5.7.1 |
| anaconda | 2020.11 |
| blast | 2.10.0 |
| boost | 1.76.0 |
| bowtie2 | 2.4.1 |
| bwa | 0.7.17 |
| clustalo | 1.2.4 |
| cgal | 5.0.4 |
| dedup | 0.12.8 |
| diamond | 2.0.9 |
| emboss | 6.6.0 |
| exonerate | 2.4.0 |
| fastqc | 0.11.9 |
| fastsimcoal | 2.6.0.3 |
| fasttree | 2.1.11 |
| fineradstructure | 0.3.2 |
| gatk | 4.2.0.0 |
| gcc | 9.3.0 |
| gdal | 2.4.2, 3.1.1, 3.4.1 |
| geos | 3.7, 3.8.1|
| getorganelle | 1.7.1 |
| gnu-parallel | 20200722 |
| hmmer | 3.3.2 |
| [hybpiper](./software/hybpiper.md) | 1.3.1 |
| iqtree | 1.6.12, 2.0.6 |
| json-c | 0.14 |    
| mafft | 7.471 |
| newick-utils | 1.6 |
| openjdk | 11, 14.0.2 |
| paftools | 0.0.1 |
| paml | 4.9j |
| phylip | 3.697 |
| phyutility | 2.7.1 |
| postgis | 3.0.1 |
| postgresql | 12.3 |
| proj | 6.2 |
| protobuf-c | 1.3.3 |
| protobuf | 2.6.1 |
| [python](./software/python.md) | 2.7.18, 3.7.9 |
| R | 3.6.3, 4.0.2 |
| raxml | 8.2.12 |
| raxml-ng | 1.0.1 |
| rdptools | 2.0.3 |
| samtools | 1.10 |
| seqkit | 0.13.2 |
| seqtk | 1.3 |
| sfcgal | 1.3.8 |
| [slurm](./software/slurm.md) | 19.05.5 |
| spades | 3.14.0 |
| sratoolkit | 2.10.8 |
| stacks | 2.54 |
| structure | 2.3.4 |
| treeshrink | 1.3.5 |
| trimal | v1.4.1 |
| trimmomatic | 0.39 |
| vcftools | 0.1.16 |



