# **Analyse target capture data to obtain regions of interest**
  
## **1. Working environment, pre-requisites, and best practices**

Processing sequencing data is much easier, faster and customizable using command line. Many bioinformatic tools are free and designed to work in a unix-like environment, so people usually analyse NGS data on OS X or Linux computers.  
  
There are already many free tools, pipelines and tutorials available so most often you just need to know enough basic commands to link these tools together and to parse results, so **don’t panic**, and don’t hesitate to google your problem!  

Tutorials to **learn basic linux commands** can be found on the Internet. Knowing basic commands will be necessary. You should at least be able to create a directory, move from a directory to another, copy or move files, look into the beginning or the end of a file, find a pattern inside a file, and get information about a particular command.
  
More important than knowing many commands is to **understand the principles behind the tool that you use**, so that you can correctly analyze the data and properly interpret the results. But this does not require high bioinformatic skills, it requires to read the manual or article associated with the tool. More on this topic is provided [here](http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/cluster/cluster-tips/).  
  
When you cannot find the tool you need or when you have difficulties to understand what is happening, ask a (bio)informatician!  
  
Kew has computing facilities that have been set up to enable the analysis of large amounts of target capture sequencing data by multiple users. Before using them, please ensure to:  
  
- **make yourself known** to Michael Chester or Pepijn Kooij for the general usage machines and to James Crowe for the cluster.
- **get familiar with the [facilities](http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/Machines/)** 
- **take note of the general best practices described [here](http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/best-practice/Best_practice/), and of the best usage practices described [here](http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/utils/logging-jobs/) for the general usage machines, and [here](http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/cluster/__intro/) for the cluster.**

Below we provide information on our current strategies to analyse target capture data to obtain multiple sequence alignments for individual genes.  
We also list useful software and give some default commands to use them, as well as some tips to use these software on multiple samples at once.  
The commands provided here are not meant to be copied and pasted directly (and they probably won't work as such), but they are given as a reference and starting point for beginners. You should adapt the commands and options to your dataset after reading the software documentation, probably try various options, and think about which steps are necessary or not to answer your research questions.

## **2. Checking data quality**
  
Usually Illumina sequencing data come back to you already **demultiplexed**: the sequencing machine created sets of files for each sample based on a sample sheet indicating which indexes corresponded to which sample. If the data are not demultiplexed, there are scripts online to do it.  

If the sequencing was **paired-end**, the data come in two files usually labelled R1 and R2. Each sequencing **read** in file R1 has a mate at the same position in file R2. The two mates correspond to the two extremities of a DNA fragment. Knowing that read 1 and read 2 correspond to a same fragment is very helpful when trying to assemble reads together, because we know that read 1 and read 2 are from two genomic regions that are separated by a distance inferior to the library size. More on paired-end sequencing and the resulting data can be found [here](https://github.com/sidonieB/bioinfo-utils/blob/master/docs/advice/images/Adapters.pdf) and in documents cited therein.
  
The format of the data is [**fastq**](https://en.wikipedia.org/wiki/FASTQ_format), which means that you have the sequencing reads and the quality of each **base** (nucleotide) of the read inside a single file. The quality of each base is expressed as the probability of the base to have been wrongly identified ("called") by the Illumina software. This is the [**phred score**](https://en.wikipedia.org/wiki/Phred_quality_score). Instead of being directly written in the file, each phred score is represented by a single character, following a code. This reduces the space taken by the fastq file. There are different codes that are used by different sequencing technologies. Current (2018) Illumina software (>v.1.8) use **phred33**. This is important to know because some data processing tools ask the user to specify it. 
  
The first thing to do when you get your data is to check if the reads are of sufficient quality, and to decide what to do to improve the quality of the individual reads and of the whole dataset. This is also the step where you can spot contamination by completely unrelated organisms (for instance fungi or bacteria when sequencing plants).
  
A great software to do this is [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) (S. Andrews, Babraham Bioinformatics), but there are other programs available.

To understand the graphical output of FastQC please follow this [link](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/).

Looking at the FASTQC results should help you decide which quality score threshold you want to accept as sufficient for each read base or each read. If your data is not of very good quality you may prefer to set a lower quality threshold so that you can still have enough data to perform your analyses, but if you do this you will have to keep in mind that there may still be many errors in the reads. This may be acceptable depending on your question or depending on how many reads of a base of interest you have.

An alternative to look at the quality of all the samples could be to use the script “clean_reads.py” of the pipeline [SEQCAPR](https://peerj.com/preprints/26477/) (Andermann et al., 2018). This script will trim the reads (see below) and produce a graphical summary of their quality for all species together.

### CODE TIPS

The **wild card** is very useful to perform simple operations on multiple inputs.
For instance, to move all files with the "html" extension to a directory called "dir", you can use a wild card like this:
```
mv *.html dir
```
If you want to unzip files, you can use the command 
```
gunzip file
```
But ask yourself if it is really necessary before, because you will use more space.
The program fastqc works on zipped (.gz) files as well as on fastq files.

**Loops** are used to perform a same operation (or suite of operations) on multiple inputs, one input after the other.
The basic structure of the loop is:
**for each_input; do (the operation); done**
For instance, you can run the fastqc command on all files finishing by ".fastq" by typing:
```
for f in *.fastq; do (fastqc $f); done
```
"for f in \*.fastq" sets the loop: the loop will iterate as many times as there are objects of name finishing by ".fastq" in the current directory.
At each iteration, a variable named f is created, and the object of name finishing by ".fastq" on which the loop is currently iterating is assigned to f, overwriting the previous value of f.
"do ()" indicates an action to perform at each iteration of the loop (for instance run fastqc with the variable f as input). 
$f indicates that f is a variable.

To copy files from your laptop/desktop to the remote server and vice versa, you can use the command **scp**:
```
scp path/to/file user@host_address:/path/to/directory

scp user@host_address:/path/to/file path/to/directory
```
The first command copies a file from your computer to the remote server (you need to know the address of the server and to have a user account on it).
The second command copies a file from the server to your computer.
You can use loops or wild cards to copy many files at once.

## **3. Cleaning data**

Once you know how you should clean your data, you can use a tool such as Trimmomatic () to do it.
Trimming tools perform various operations, depending on the tool and on the options you chose. 
They trim, i.e they cut, the end of the reads if they match adapter sequences (indicated by the user).
They trim the reads at the end and sometimes at the beginning, based on the quality of the base(s) or arbitrarily.
They remove completely some reads, based on their quality and/or their length.
If the data was paired-end, and one of the reads of the pair has been removed but not the other, the remaining read is either removed too, or written in separate file of "unpaired" reads.
This allows to keep two files of trimmed paired reads where reads at the same line number in both files correspond to the two reads of a pair.
In Trimmomatic, this results in the creation of four output files: two files containing respectively read 1 and read 2 of each read pair, and two files containing respectively read 1 of the pairs for which read 2 has been deleted, and read 2 of the pairs for which read 1 has been deleted.

The manual of Trimmomatic is worth reading. As a general rule, we found that the MAXINFO setting is complicated. It takes a bit of trial and error to find the right parameters but it seems to be possible to keep the quality very high but dropping very few reads altogether, compared to SLIDINGWINDOW which seems to drop more. 
Setting the targetlength parameter too low does result in lots of reads being dropped but the strictness parameter can be turned up to the maximum of 1 and still just trims without completely dropping reads, on the datasets that we tested.
Apparently MAXINFO should only be used instead of SLIDINGWINDOW, not both together. 
We did not find necessary to use TRAILING or LEADING but it might be necessary to use CROP on the long reads.

If you used the Illumina adapters xxxxxx, the adapter file TruSeq3-PE-2.fa in "Trimmomatic-0.36/adapters/" should be the one you need.

After you cleaned the data, you should ideally check with fastqc if your clean data are as you expect, and you should check the output of the trimming program, to know how many reads you lost, and how many you trimmed.
In general, trimming a new dataset requires multiple trials. But after a while, it becomes easier to know what will work on which kind of dataset.


Command tips

You can customize loops to create outputs with informative names in the following way:
for i in *.fastq; do (command $i > ${i/.fastq}_paired.fastq); done
In this example, we create an output with the same name as the input, but we remove ".fastq" from this name, and we replace it by "_paired.fastq", to indicate that the output will contain reads belonging to intact pairs.

In the same way you can construct a loop that will be able to pick additional inputs based on the first input name that you specify:
for i in *R1.fastq; do (command $i ${i/R1.fastq}R2.fastq > ${i/.fastq}_paired.fastq ${i/R1.fastq}R2_paired.fastq); done
This loop iterates on each file finishing by R1.fastq, and uses it as input as well as the file with the same name but finishing by R2.fastq
It also creates two output files with names finishing by R1_paired.fastq and R2_paired.fastq

The trimmomatic command can be designed the same way, carefully. For instance:

for f in *R1_001.fastq; do (java -jar ~/softwares/Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 $f ${f/R1_001.fastq}R2_001.fastq ${f/R1_001.fastq}R1_001_Tpaired.fastq ${f/R1_001.fastq}R1_001_Tunpaired.fastq ${f/R1_001.fastq}R2_001_Tpaired.fastq ${f/R1_001.fastq}R2_001_Tunpaired.fastq ILLUMINACLIP:../softwares/Trimmomatic-0.36/adapters/TruSeq3-PE-2.fa:1:30:7:2:true MAXINFO:40:0.85 MINLEN:36); done

BE CAREFUL! YOU NEED TO UNDERSTAND THE ABOVE COMMAND AND ADAPT IT TO YOUR NEEDS/INPUT NAMES!



## **4. Chosing a strategy to assemble the data and formatting the reference file**

There are multiple pipelines to analyze target capture sequencing data and to produce phylogenies from them. 
At Kew, we often use HybPiper or a homemade pipeline inspired by it: PAFTOOLS. 
However, there may be more adequate pipelines depending on your needs, or, more likely, you will need to customize an existing pipeline.
HybPiper has the advantage to be relatively easy to customize, his author Matt Johnson https://github.com/mossmatters is very helpful, and the pipeline allows us to retrieve the splash-zone, which is of interest to many people working at Kew.
What follows is based on Hybpiper. If you want to use PAFTOOLS, talk to Jan Kim.
You should read about HybPiper here https://github.com/mossmatters/HybPiper and here https://github.com/mossmatters/KewHybSeqWorkshop before trying it by yourself, because the original tutorial is already very detailed and useful, and because it may contain updates that we overlooked (please let us know!).

Hybpiper and PAFTOOLS both rely on aligning (mapping) the reads on the sequences of the genes that you want to retrieve, keeping the reads that align well to the target genes, as well as their mates, and assembling separately the groups of reads corresponding to each gene to generate a consensus for each gene.
However, even if you do target capture, it may be a good idea to map the reads on a full genome, where your targets are annotated. This may improve the read mapping, avoid artefacts created by wrond mappings, and make easier the recovery of the regions flanking the genes of interest.
Let us know if you test it!

For hybpiper, you need to provide a reference file containing the genes that you are targetting.
Ideally the file should contain the regions for which you created baits, and only them.
In general, people give gene coding sequences, i.e. exons concatenated together.
The format should be as following (in the same order, with the hyphen):
>ReferenceSpecies-geneName
AAAAAAAAAAAAAAAAAAAAAAA
This allows to provide the same gene from different species, and to align homologous genes to each other later.

You can ask hybpiper to retrieve other things than your target. For instance you can provide plastid genes, or even complete plastid genomes, formatted the same way.

To create a reference file for plastid regions, there are multiple approaches.
You can download a plastome in Genbank, in format .gb, open it in Geneious, use the annotation tool to extract all regions that you are interested in, and rename them as required by hybpiper using a smart text editor that allows you to use regular expressions to perform complext find and replace operations, or the command sed.
When you want to do it for multiple plastomes, instead of Geneious you can use/customize one of our scripts, to extract only the regions you want based on the annotations, and rename them as you wish.

Depending on your input it will be relevant or not to use the "intronerate" option without modifications (see below).
If you chose to use blast, your reference file will have to provide amino-acid sequences, so it may not make sense to use blast for something else than coding sequences.
However, we found out empirically that blast allows to recover less reads, but longer genes, than with bwa, regardless if sequences were coding or not.


## **5. Tips when running Hybpiper**

Hybpiper relies on a namelist, which is a list of all the samples on which you want to run hybpiper.
The names in the list should correspond exactly to the part in each file name that is unique to each sample.
To make the list, you can use a loop such as:

for f in *_R1_001_Tpaired.fastq; do (echo ${f/_R1_001_Tpaired.fastq} >> namelist.txt); done


Dependng on where you run your analyses, you may need to put some programs in your PATH, so that the hybpiper can find the program.
To do so you should use the following command:

export PATH=$PATH:/path/to/folder/containing/the/program

This creates a new variable called PATH which contains what was before in the variable PATH, and the path to the program of interest.

You have to run the export command each time you open a new terminal, or you have to modify a particular file in the server to make it permanent. Ask the informatician in charge.

So before you panic next time you get an error from Hybpiper, please check that:
- your reference file is correctly formatted
- your namelist is correct (look inside the file using less, for instance)
- the program (bwa, blast, spades...) is in your PATH variable (check using echo $PATH)
And try to understand what Hybpiper is complaining about.
Typically if it soes not find a file, it is either one of the two latter problems, and/or your hybpiper command has a problem, usually in the way you specify the input.

Example of hybpiper command (ADAPT TO YOUR NEEDS!):

while read name 
do /home/sidonie/softwares/HybPiper/reads_first.py -b ../../targetsProbeAlignmentBaitOnly.fasta -r "$name"_R*Tpaired.fastq --prefix $name --bwa --cov_cutoff 3
done < namelist.txt

This is also a loop, but it is a "while" loop, not a for loop, and the input is provided at the end using "< namelist.txt". 
For each line in "namelist.txt", we create a variable $name which contains the line (in our case the unique identifier of each sample), and we apply a command (in our case the hybpiper command) on an input whose name is created using the variable $name + what is needed to find the input files corresponding to the sample (in our case "_R*Tpaired.fastq", note the * which allows to pick the file with the reads 1 and the file with the reads 2 at once)

See the hybpiper page to understand the command arguments, and to update it if needed.

If you want to use unpaired reads in hybpiper, you need to have all unpaired reads of one sample in one file, so if you used Trimmomatic and you have two files of unpaired reads for each sample, you can use a loop to concatenate them, such as:

for f in *R1_001_Tunpaired.fastq; do (cat $f ${f/R1_001_Tunpaired.fastq}R2_001_Tunpaired.fastq > ${f/R1_001_Tunpaired.fastq}TunpairedAll.fastq); done


Running hybpiper on many samples takes time! You should first try it on two samples to see if your commands work before submitting a long job.
If running on the servers that don't have a system of job submission, you can use some tool to be able to run the job and close your terminal.
For instance, you can use screen:
screen
ctrl-A c to get a new window
ctrl-A n or p to go to the next or the previous window
ctrl-A d to detach from the session
screen -r to reattach to the session (may have to indicate the session id, see error message if any)
screen -X -S session-id quit to kill the session


You can check for paralogs using the paralog_investigator.py script in the hybpiper directory, in the same kind of loop:
while read i
do
echo $i
python /home/sidonie/softwares/HybPiper/paralog_investigator.py $i
done < namelist.txt

Depending on the result you may want to discard a gene for a species or for all species.
This can also be a first step to identify recent whole genome duplications, or ancient gene duplications.

After hybpiper has run, you can make a file for each target region provided in the reference file, using retrieve_sequences.py from the hybpiper directory:
python retrieve_sequences.py targetsProbeAlignmentBaitOnly.fasta . dna

(The dot is the current directory, "dna" tells the script to retrieve only the sequences corresponding to the targets, not the flanking regions, see below)



You can retrieve the flanking regions of the target regions using the intronerate script from the hybpiper directory.

while read name
do python intronerate.py --prefix $name
done < namelist.txt

To make files with only the flanking regions of a target for all samples, you can use the command retrieve_sequences.py with the "intron" option:
python retrieve_sequences.py targetsProbeAlignmentBaitOnly.fasta . intron

To make files with the target and its flanking regions for all samples, you can use the command retrieve_sequences.py with the "supercontig" option:
python retrieve_sequences.py targetsProbeAlignmentBaitOnly.fasta . supercontig

This is possible because for each target, the script generates a sequence corresponding to the concatenation of the flanking regions of the target (the "intron" in hybpiper's language), 
and a sequence corresponding to the flanking region(s) + the target (the "supercontig" in hybpiper's language)

Example:

Original sequence (only the xxx parts were baited: they are the targets):
---------xxxxxxxxxxxx----------xxxxxxxxxxxxxxxxxxxxx------------

"dna":
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

"intron":
-------------------------------
"supercontig":
---------xxxxxxxxxxxx----------xxxxxxxxxxxxxxxxxxxxx------------


This is an ideal case when one manages to retrieve the complete target and the complete flanking region, but you may just retrieve fragments of them, or you may retrieve longer sequences than what you expect if there was an insertion in the sequenced species compared to the reference.


ADVICE: 
Organize yourself! Make folders corresponding to the different steps, and move the relevant files in them.
For instance you may have a folder with the raw data, a folder with the trimmed data, a folder with the hybpiper output of a given run, a folder with the final gene files...

Tidy up! Hybpiper provide a cleaning script that removes unnecessary files. In addition, after a few trials you should be able to know what files are really necessary and what files can be deleted.
Work in a reproducible way, for you and for others. 
At the minimum, keep track of your commands (you can consult the output of the history command if you don't remember them), this is the first step towards building your own pipeline.
You can put all commands in a file and make a script out of them, or at least come back to them and copy paste them quickly in the terminal following your needs.
Ideally, run the commands in a container (eg. using docker) so that everybody can reproduce your work by launching the container.



