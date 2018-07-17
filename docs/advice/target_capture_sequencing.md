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
  
The ratio of specific/non-specific (= **on/off target**) captured DNA illustrates how successful was the **enrichment** of the libraries in target DNA: the higher the ratio is, the more successful the enrichment is, the lesser sequencing effort is needed.

### Sequencing of the captured DNA

We often put multiple pools of captured DNA together (again because it is cheaper) in a single tube to proceed with the sequencing. This is the **sequencing pool**.  
  
The sequencing pool is loaded into the Illumina sequencing machine (MiSeq, HiSeq, etc.), which will **read** the DNA sequences (details here). 
  
We usually perform **paired-end** sequencing: the DNA fragments are read twice, once from each extremity, producing a pair of reads that are known to come from a same fragment.  
  
NB: Because the DNAs of multiple samples are mixed in the hybridization pool(s) and/or in the sequencing pool, it is crucial that the DNA libraries of these samples are made with adapters containing different indexes, so that we can tell what DNA sequence is from what sample. The easiest way to ensure this is to **think about what samples should go in a same sequencing pool before starting to prepare the libraries**.

## Details

### Details about the bait design

The RNA hybridizes with the DNA, and the more similar the bait is to the target, the more stable the hybridization is. An ideal bait should thus be very similar to the target gene and much less similar to any other un-desired region. One can optimize this by choosing target regions that don’t have very similar un-desired copies in the genome.  
  
This does not obligatory mean that one has to chose low-copy regions: you may be interested in a gene family, or in recovering all paralogs of a certain gene, in which case you will design baits in the regions that you expect to be the most conserved across the genes family / the paralogs. But these baits should still ideally be much more similar to these regions than to any other non-desired region of the genome.  
  
When we want to be able to capture genetically divergent taxa with a same bait, one way is to have baits targeting regions that we expect to be conserved between the taxa, typically exons. But the problem then is that the targeted regions may be too conserved to provide phylogenetic signal. There are multiple ways around this, for instance: 
  
* Oone can target regions that are conserved enough to be captured by a same bait but divergent enough so that they provide phylogenetic signal. This is possible to a certain extent because baits can hybridize to divergent DNA, but at some level of divergence this becomes inefficient because the baits will hybridize a lot to non-desired regions.  
In addition, since the efficiency of hybridization is proportional to the bait-target similarity, if, in a same hybridization pool, some taxa have DNA more similar to the baits than other taxa, the captured DNA may come mostly from the taxa with the DNA the most similar to the baits.
  
* Another way is to design multiple baits targeting the same DNA region, with some baits more similar to some taxa than to others. This is the approach chosen for the [PAFTOL project], but they refined it, as explained in [their article] (link to paper).
  
* Another, compatible, way is to target regions that are flanked by more variable regions. The flanking regions will come along during the capture if there are DNA fragments containing part of the target region (enough for a bait to hybridize) and part of the flanking region. The larger the library size is, the longer the flanking region that can be captured is, but the higher the effort required to sequence the complete flanking region will be, as shown in [Figure 3].  
The sequenced flanking regions form what [some people] call the **splash zone**. 
  
At the inter-generic level, it may be difficult to find conserved regions flanked by regions that are variable but still conserved enough to be aligned between taxa, so the last approach is most beneficial at the intra-generic level. 
This is why the [PAFTOL project] relies mostly on having multiple baits targeting the same DNA regions in multiple plant families, and on the fact that inside a family these regions are conserved enough to be targeted by a same bait but also variable enough to provide phylogenetic resolution at the genus level.  
However, the PAFTOL bait kit can also be used to capture the flanking regions of the PAFTOL targets, which can then be used to answer intra-generic phylogenetic questions and/or build species-level barcoding libraries. 


Details about the DNA library size and the splash zone
Why do we have to fragment the DNA? 
Because the Illumina machines do not work with DNA fragments longer than ca. 450 bp (Hiseq X), or ca. 800 bp (other Hiseq). (This is not up-to-date, more precise information welcome!)
Why don’t we use long read machines such as the MinION of Oxford Nanopore Technologies or PacBio? 
Because Illumina gives much more data at a lower cost, and with a lower error rate. Ideally, to get the most of each sample we collect, we should sequence its full genome using both short and long-read sequencing. However, long-read technologies are still too expensive, and it is usually not possible to get long reads from the herbarium specimens because their DNA is already fragmented. Using the short read approach is thus not only cost-efficient and sufficient to achieve phylogenetic inference, it is also the only way to use DNA from our herbarium collections.
Which fragment size to choose between the sizes allowed by the Illumina machines?
Many things to consider:
- If you sequence together DNAs of different fragment sizes, the smallest fragments will be sequenced preferentially, so in general you may want to fragment your DNAs so that all your libraries have a similar size. Or to sequence libraries of different sizes separately (which increases sequencing costs).
Some size variation is ok, and one can adjust the molarity of individual libraries to correct for it, but usually the more variable the libraries, the less homogenous the results.
- The longer the fragment size is, the longer may be the splash zone (at the condition of a sufficient sequencing effort, see figure 3)
- If a non-negligible proportion of the DNA fragments (including adapters) is smaller than the read length you chose, the sequencing will fail.

Details about the adapters 
Adapters are necessary because:
	- they contain two “indexes” (in our case index 5 and index 7), the combination of which is unique for each sample and thus allows to sequence multiple individuals together and still recognize which sequence comes from which sample.
	- they contain “primers”, which are used to amplify the DNA by PCR during library preparation and after the hybridization, and to replicate the DNA during the sequencing process.
	- they allow the DNA fragment to be fixed on the “flow cell” during the sequencing process.

Details about how the adapters are put on the DNA, how the DNA is sequenced, what data result from this, and why we end up with pieces of adapters in the reads are given here.


