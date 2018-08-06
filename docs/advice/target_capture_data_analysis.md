# **Analyse target capture data to obtain gene alignments**
  
## **1. Working environment and best practices**

Processing sequencing data is much easier, faster and customizable using command line. Many bioinformatic tools are free and designed to work in a unix-like environment, so people usually analyze NGS data on OS X or Linux computers.  
  
There are already many free tools, pipelines and tutorials available so most often you just need to know enough basic commands to link these tools together and to parse results, so **don’t panic**, and don’t hesitate to google your problem!  
  
More important than knowing many commands is to **understand the principles behind the tool that you use**, so that you can correctly analyze the data and properly interpret the results. But this does not require high bioinformatic skills, it requires to read the manual or article associated with the tool. More on this topic is provided [here](http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/cluster/cluster-tips/).  
  
When you cannot find the tool you need or when you have difficulties to understand what is happening, ask a (bio)informatician!  
  
Kew has computing facilities that have been set up to enable the analysis of large amounts of target capture sequencing data by multiple users. Before using them, please ensure to:  
  
- **make yourself known** to Michael Chester or Pepijn Kooij for the general usage machines and to James Crowe for the cluster.
- **get familiar with the [facilities](http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/Machines/)** 
- **take note of the general best practices described [here](http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/best-practice/Best_practice/), and of the best usage practices described [here](http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/utils/logging-jobs/) for the general usage machines, and [here](http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/cluster/__intro/) for the cluster.**

## **2. Checking data quality**
  
Usually Illumina sequencing data come back to you already **demultiplexed**: the sequencing machine created a file for each sample based on a sample sheet indicating which indexes corresponded to which sample. If the data are not demultiplexed, there are scripts online to do it.  
  
The format of the data is [**fastq**](https://en.wikipedia.org/wiki/FASTQ_format), which means that you have the sequencing **reads** and the quality of each **base** (nucleotide) inside a single file. The quality of each base is expressed as the probability of the base to be wrong. This is the [**phred score**](https://en.wikipedia.org/wiki/Phred_quality_score). Instead of being directly written in the file, each phred score is represented by a single character, following a predefined code. This reduces the space taken by the fastq file. There are different codes that are used by different sequencing technologies. Current (2018) Illumina software (>v.1.8) use **phred33**. This is important to know because some data processing tools ask the user to specify it. 
  
  
The first thing to do when you get your data is to check each file to see if the reads are of sufficient quality, and to decide what to do to improve the quality of the individual reads and of the whole dataset. This is also the step where you can spot contamination by completely unrelated organisms (for instance fungi or bacteria when sequencing plants).
A great software to do this is FastQC (S. Andrews, Babraham Bioinformatics) https://www.bioinformatics.babraham.ac.uk/projects/fastqc/ , but there are other programs available.
To use FastQC on multiple samples, you can do:

To understand the graphical output of FastQC please follow this link: https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/ 
An alternative to look at the quality of all the samples is to use the script “clean_reads.py” of the pipeline SEQCAPR (Andermann et al., 2018; https://peerj.com/preprints/26477/ ). This will trim the reads (see below) and produce a graphical summary of their quality for all species together (not tried yet).

Looking at the FASTQC results should help you decide which quality score threshold you want to accept as sufficient for each read base or each read. If your data is not of very good quality you may prefer to set a lower quality threshold so that you can still have enough data to perform your analyses, but if you do this you will have to keep in mind that there may still be many errors in the reads. This may be acceptable depending on your question or depending on how many reads of a base of interest you have.


## **3. Cleaning data**
