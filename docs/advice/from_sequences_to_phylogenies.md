# **Phylogenomics tips**
## **1. Multiple Sequence Alignments (MSAs)**
There are many different programs to align sequences.  
None of them is guarantied to find the optimal alignment.  
Performance depends on your data and how you tune the parameters.
Below we give examples of use and remarks about the software that we tend to use the most.  

### MAFFT
See the documentation [here](https://mafft.cbrc.jp/alignment/software/)  
Example of command to run MAFFT on multiple files using GNU parallel (see Matt Johnson explanation [here](https://github.com/mossmatters/KewHybSeqWorkshop/blob/master/Alignment.md)):
```
# Make a list of the gene names:
for f in *.fasta; do (echo $f >> genenames.txt); done
# look at the list:
less genenames.txt
# run MAFFT on all genes from the list:
parallel --eta "mafft --localpair --adjustdirectionaccurately --maxiterate 1000 {} > {}.aligned.fasta" :::: genenames.txt
```
This is just an example, look at the documentation to chose adequate options!
Note the "--adjustdirectionaccurately" option, which reverse complement sequences if necessary.
  
As well as running MAFFT with the GNU-Parallel command, it’s possible, as with HybPiper, to run this in parallel on a cluster as a simple array job using one CPU for each gene.  
  
Alternatively, for aligning big alignments MAFFt has a –thread option that can be set to the number of cores on your machine.   
Explained [here](https://mafft.cbrc.jp/alignment/software/multithreading.html).  
There is also a [MPI version](https://mafft.cbrc.jp/alignment/software/mpi.html).


### PASTA
See the documentation [here](https://github.com/smirarab/pasta).  
What follows needs testing and proofreading. Comments welcome!  
PASTA aligns sequences following an iterative approach that uses a user-provided guide tree to generate an alignment, generates a new tree from this alignment, use this tree to improve the previous alignment, and does it again a user-defined number of times.  
PASTA is able to deal with very large numbers of sequences to align because it splits the data in subsets of sequences, align the subsets, and then combine the alignments.  
PASTA works with different alignment software, including MAFFT.    
Using MAFFT through PASTA may give better results than using MAFFT alone, especially because PASTA tends to infer gaps instead of forcing alignment between very divergent sequences.  
Recent work by people in [T. Warnow's group](http://tandy.cs.illinois.edu/) suggest that a combination of PASTA and [BAli-Phy](http://www.bali-phy.org/) could [work well](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-016-3101-8#Sec15) although more testing on real data is needed (pers. com. from Mike Nute, PhyloSynth symposium, Montpellier, France, August 2018).

## **2. Gene trees**
## **3. Spotting alignment problems**
## **4. Rooting trees**
## **5. Infer species tree with ASTRAL**
## **6. Calculate bipartition support**
## **7. Visualize support on the species tree**
