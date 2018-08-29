# **Phylogenomics tips**
## **1. Multiple Sequence Alignments (MSAs)**
There are many different programs to align sequences.  
None of them is guarantied to find the optimal alignment.  
All of them perform more or less good depending on your data and how you tune their parameters.
Below we give examples of use and remarks about the software that we tend to use most.  

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
  
As well as running MAFFT with the GNU-Parallel command, it’s possible, as with HybPiper, to run this in parallel on a cluster as a simple array job using one CPU for each gene.  
  
Alternatively, for aligning big alignments MAFFt has a –thread option that can be set to the number of cores on your machine.   
Explained [here](https://mafft.cbrc.jp/alignment/software/multithreading.html).
There is also a [MPI version](https://mafft.cbrc.jp/alignment/software/mpi.html).


### PASTA
## **2. Gene trees**
## **3. Spotting alignment problems**
## **4. Rooting trees**
## **5. Infer species tree with ASTRAL**
## **6. Calculate bipartition support**
## **7. Visualize support on the species tree**
