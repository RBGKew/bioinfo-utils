## **Understanding target capture sequencing data**

Understanding how the data have been generated is necessary to choose the right analysis tools, and to properly interpret the results.  
Here we only talk about data obtained from the Illumina sequencing of target DNA fragments captured using RNA baits. 

### Bait design

We first have to design baits to capture the target DNA

[Figure 1](https://github.com/sidonieB/bioinfo-utils/blob/master/docs/advice/images/Fig1_bait_design.jpg)

1. we choose some genes that we want to study. These genes are the **target** genes.
2. we design RNA sequences (usually 120 bp long) that align to the target genes.  
These sequences are called **baits**, because they will allow to capture the target genes.  
The baits can be designed to overlap each-other, we talk about **bait tiling**. 
3. we synthesize the baits with biotinylated nucleotides: this is the so called **bait kit**

People usually rely on a company to design and to synthesize the baits.

### DNA preparation and target capture

Once the bait kit is ready, it can be used to capture the target regions from one or multiple DNA samples.

[Figure 2](https://github.com/sidonieB/bioinfo-utils/blob/master/docs/advice/images/Fig2_target_capture.jpg)

1. we extract the genomic DNA of an individual. 
2. we prepare the DNA of this sample so that all its DNA fragments have a similar size (details here)
3. we put **adapters** containing **primers** and **indexes** at both extremities of all the DNA fragments (details here). The result is called a DNA **library**.
4. we add the baits and a few other reagents, and we leave it 16 to 24 hours at 65 degrees Celsius. This is the **hybridization reaction**: the baits bind preferentially to the DNA to which they are the most similar (i.e. to the targets), but also to other DNA regions (details below). 
We usually **multiplex**, i.e. we put multiple DNA libraries together in a single tube (because it is cheaper). This is the **hybridization pool**.  
5. At the end of the hybridization, the baits + target DNA are **captured** using magnetic beads coated with streptavidin, which binds to the biotin of the baits. 
The beads+baits+target DNA cluster on the magnet while the reagents and the DNA that did not attach well to the baits are washed away. 
6. Finally, the DNA that attached to the baits is eluted, and amplified by PCR. 
We thus end up with the **captured DNA**, containing mostly the target genes but also some non-specific = **off target** DNA that came along. 
The ratio of specific/non-specific (= **on/off target**) captured DNA illustrates how successful was the **enrichment** of the libraries in target DNA: the higher the ratio, the most successful the enrichment, the least sequencing effort needed.

Finally, we can sequence the captured DNA:
We often put multiple pools of captured DNA together (again because it is cheaper) in a single tube to proceed with the sequencing. This is the “sequencing pool”. This sequencing pool is loaded into the Illumina sequencing machine (MiSeq, HiSeq, etc.), which will “read” the DNA sequences (details here). 
We usually perform “paired-end” sequencing: the DNA fragments are read twice, once from each extremity, producing a pair of reads that we know come a same fragment (details here).
NB: Because the DNAs of multiple samples are mixed in the hybridization pool(s) and/or in the sequencing pool, it is crucial that the DNA libraries of these samples are made with adapters containing different indexes, so that we can tell what DNA sequence is from what sample (details here). The easiest way to ensure this is to think about what samples should go in a same sequencing pool before starting to prepare the libraries.


## &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**1. Checking data quality**
## &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**2. Cleaning data**
