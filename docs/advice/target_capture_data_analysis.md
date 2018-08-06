# **Analyse target capture data to obtain gene alignments**
  
## **1. Working environment and best practices**

Processing sequencing data is much easier, faster and customizable using command line. Many bioinformatic tools are free and designed to work in a unix-like environment, so people usually analyse NGS data on OS X or Linux computers.  
  
There are already many free tools, pipelines and tutorials available so most often you just need to know enough basic commands to link these tools together and to parse results, so **don’t panic**, and don’t hesitate to google your problem!  
  
More important than knowing many commands is to **understand the principles behind the tool that you use**, so that you can correctly analyze the data and properly interpret the results. But this does not require high bioinformatic skills, it requires to read the manual or article associated with the tool. More on this topic is provided [here](http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/cluster/cluster-tips/).  
  
When you cannot find the tool you need or when you have difficulties to understand what is happening, ask a (bio)informatician!  
  
Kew has computing facilities that have been set up to enable the analysis of large amounts of target capture sequencing data by multiple users. Before using them, please ensure to:  
  
- **make yourself known** to Michael Chester or Pepijn Kooij for the general usage machines and to James Crowe for the cluster.
- **get familiar with the [facilities](http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/Machines/)** 
- **take note of the general best practices described [here](http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/best-practice/Best_practice/), and of the best usage practices described [here](http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/utils/logging-jobs/) for the general usage machines, and [here](http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/cluster/__intro/) for the cluster.**

Below we provide information on our current strategies to analyse target capture data to obtain multiple sequence alignments for individual genes.  
We also list useful software and give some default commands to use them, as well as some tips to use these software on multiple samples at once.  
The commands provided here are not made to be copied and pasted directly (and they probably won't work as such), but they are given as a reference and starting point for beginners. You should adapt the commands and options to your dataset after reading the software documentation, probably try various options, and think about which steps are necessary or not to answer your research questions.

## **2. Checking data quality**
  
Usually Illumina sequencing data come back to you already **demultiplexed**: the sequencing machine created sets of files for each sample based on a sample sheet indicating which indexes corresponded to which sample. If the data are not demultiplexed, there are scripts online to do it.  

If the sequencing was **paired-end**, the data come in two files usually labelled R1 and R2. Each sequencing **read** in file R1 has a mate at the same position in file R2. The two mates correspond to the two extremities of a DNA fragment. Knowing that read 1 and read 2 correspond to a same fragment is very helpful when trying to assemble reads together, because we know that read 1 and read 2 are from two genomic regions that are separated by a distance inferior to the library size. More on paired-end sequencing and the resulting data can be found [here](https://github.com/sidonieB/bioinfo-utils/blob/master/docs/advice/images/Adapters.pdf) and in documents cited therein.
  
The format of the data is [**fastq**](https://en.wikipedia.org/wiki/FASTQ_format), which means that you have the sequencing reads and the quality of each **base** (nucleotide) of the read inside a single file. The quality of each base is expressed as the probability of the base to have been wrongly identified ("called") by the Illumina software. This is the [**phred score**](https://en.wikipedia.org/wiki/Phred_quality_score). Instead of being directly written in the file, each phred score is represented by a single character, following a code. This reduces the space taken by the fastq file. There are different codes that are used by different sequencing technologies. Current (2018) Illumina software (>v.1.8) use **phred33**. This is important to know because some data processing tools ask the user to specify it. 
  
The first thing to do when you get your data is to check if the reads are of sufficient quality, and to decide what to do to improve the quality of the individual reads and of the whole dataset. This is also the step where you can spot contamination by completely unrelated organisms (for instance fungi or bacteria when sequencing plants).
  
A great software to do this is [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) (S. Andrews, Babraham Bioinformatics), but there are other programs available.

To understand the graphical output of FastQC please follow this [link](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/).

Looking at the FASTQC results should help you decide which quality score threshold you want to accept as sufficient for each read base or each read. If your data is not of very good quality you may prefer to set a lower quality threshold so that you can still have enough data to perform your analyses, but if you do this you will have to keep in mind that there may still be many errors in the reads. This may be acceptable depending on your question or depending on how many reads of a base of interest you have.

An alternative to look at the quality of all the samples could be to use the script “clean_reads.py” of the pipeline [SEQCAPR](https://peerj.com/preprints/26477/) (Andermann et al., 2018). This script will trim the reads (see below) and produce a graphical summary of their quality for all species together.

Commands tips:

## **3. Cleaning data**
