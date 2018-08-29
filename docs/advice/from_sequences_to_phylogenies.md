# **Phylogenomics tips**
## **1. Multiple Sequence Alignments**
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


### Concatenate alignments (if needed)

We know of two command line tools: [FASconCAT-G](https://github.com/PatrickKueck/FASconCAT-G) and [AMAS](https://github.com/marekborowiec/AMAS). The latter seems more robust to big alignments.
The command to run AMAS is:
```
python3 AMAS.py concat -i input-file*.txt -f fasta -d dna
```
AMAS.py does some other useful things including giving a summary of an alignment with number of parsimony informative sites etc:
```
python3  AMAS.py summary -i alignment.fasta -f fasta -d dna
```

### Trimming alignments
We have used [trimAl](http://trimal.cgenomics.org/).  
It can be used to trim out columns or sequences based on their gap content.  
For instance:
```
trimal -in concatenated.out -out concat_trimmalled.fas -automated -resoverlap 0.65 -seqoverlap 0.65
```
  
Another suite of tools to perform similar tasks and many others is [phyutility](https://github.com/blackrim/phyutility).  

## **2. Gene trees**

### Model selection

### Gene tree estimation using maximum likelihood
We often use RAxML, see full documentation [here](https://sco.h-its.org/exelixis/web/software/raxml/) to understand the options.  
Example of command to get gene trees with 100 bootstrap replicates, with branch lengths in the bootstrap files (option -k):
```
for f in *.fasta; do (raxmlHPC-PTHREADS -m GTRGAMMA -f a -p 12345 -x 12345 -# 100 -k -s $f -n ${f}_tree -T 4); done
```
Be careful with the -T option, which controls the number of threads to use!  
The -p and -x options are important for reproducibility, the number does not matter but you should take note of it (see the manual).

The trees to be used for species tree estimation with ASTRAL (see below) are the RAxML_bipartitions.* trees, NOT the RAxML_bipartitionsBranchLabels.* trees.
  
  
## **3. Spotting alignment problems**

When you have hundreds of alignments, looking at all of them to spot wrong alignments or weird sequences becomes difficult, so people are developping tools to spot problems automatically.  

Matt Johnson's [script](https://github.com/mossmatters/KewHybSeqWorkshop/blob/master/Alignment.md#identifying-poorly-aligned-sequences) to spot anormally long branches in trees.
  
U. Mai and S. Mirarab's [Treeshrink](https://github.com/uym2/TreeShrink) to do the same.

If you can have a look at your alignments don't hesitate though...  


## **4. Infer species tree with ASTRAL**

We use ASTRAL-III (version 5.1.1 and above). See the article [here]() and ASTRAL documentation [here]().
When using ASTRAL-III, it is better to collapse very low support branches in the gene trees before running ASTRAL.  
It can be done with newick utilities in the following way (for branches with less than 10% bootstrap):  
```
~/software/newick-utils-1.6/src/nw_ed all_trees.tre 'i & b<=10' o > all_trees-BS10.tre
```

To run Astral with the -t 0 option, and get the species tree from the stdout, without any annotations or branch lengths:
```
java -Xmx12000M -jar ~/software/ASTRAL/astral.5.5.9.jar -i all_trees-BS10.tre -t 0 -o SpeciesTree.tre
```
If astral had '[p=...]' annotations (other -t options, see the manual), the following commands could help removing all annotations, but it is generally easier to rerun Astral with -t 0.
```
sed 's/\[[^\[]*\]//g'SpeciesTree.tre > SpeciesTree2.tre
sed "s/'//g" SpeciesTree2.tre > SpeciesTree3.tre
```
## **5. Rooting trees**

**WARNING!** If you use phyparts (see below) or more generally if you have to compare gene trees to your species tree, it is important that the same rooting method is applied to all trees.

### Root the species tree 

We use the command pxrr of the [phyx](https://github.com/FePhyFoFum/phyx) package:
```
~/software/phyx/src/pxrr -t SpeciesTree.tre -g outgroup_name_as_in_the_tree > SpeciesTree_PxrrRooted.tre
```
For phyparts (see below), you need to ensure that the end of the species tree has a ";" and that it finishes with \r\n:
```
sed 's/\;\n/\;\r\n/' SpeciesTree_PxrrRooted.tre > SpeciesTree_PxrrRooted_formated.tre
```
### Root many gene trees at once

You can also use the pxrr command from [phyx](https://github.com/FePhyFoFum/phyx) to root multiple trees at once, and it is also relatively flexible when you need to use multiple outgroups. See the documentation [here](https://github.com/FePhyFoFum/phyx/wiki/Program-list).  
Examples of this flexibility are welcome!
  
If you have multiple and different outgroups per gene tree, and some risk that your outgroups may not be monophyletic in some trees, you can also use our custom R script to generate the adequate command for pxrr for each tree, and then run all commands at once. 

This R script, called root_tree_general_pxrr_v2.R, will generate a command to root each tree on the first preferred taxon that is available.
Input for the script:  
Based on your species tree, create a list with the outgroups, for instance called outgroups.txt. Ensure that:
- Each outgroup is on a separate line
- If the outgroup is a clade, put all taxa of the clade on the same line separated by " ; "
- Each outgroup (and not each taxon) is enclosed in quotes
Such as:  
"OG1"  
"OG2"  
"OG3 ; OG4 ; OG5"  
"OG6"  
"OG7 ; OG8"  
"OG9"  
etc  

Put the list of outgroups in the same folder as the gene trees, avoid puting anything else in the folder.
  
When an outgroup clade is found not monophyletic in the tree, the script looks for the largest combination of the outgroups that is monophyletic and use it to root the tree.  
It will also generate a warning so that you can go and check the tree and the corresponding pxrr command if you want to be sure.  

Once the pxrr commands are generated and you are happy with them, you can run them all at once.  
  
Ensure that the end of all rooted gene trees has a ";" and that it finishes with \r\n:
```
for f in *.tre; do (sed 's/\;\n/\;\r\n/' $f > ${f/.tre}2.tre); done
```

## **6. Calculate support**

ASTRAL provides various measures of clade or bipartition [support](https://github.com/smirarab/ASTRAL/blob/master/astral-tutorial.md#branch-length-and-support).  
You can also use [phyparts](https://bitbucket.org/blackrim/phyparts) to obtain a measure of the support in each bipartition in the tree.  
  
**WARNING!**: To use phyparts properly, the species tree and the gene trees have to be rooted using the same rooting method!  

Example of phyparts command:
```
java -jar target/phyparts-0.0.1-SNAPSHOT-jar-with-dependencies.jar -a 1 -s 70 -v -d gene-trees/ -m species_tree.tre -o out-prefix
```
Use the -s option to collapse clades with a bootstrap percentage lower than the number indicated (here 70%)
  
Put the output from phyparts in a separate directory in order to visualize it (see below).
  
  
## **7. Visualize support on the species tree**

### Make piecharts based on the results from phyparts
You can generate piecharts corresponding to the results from the phyparts analysis using Matt Johnson's [script](https://github.com/mossmatters/phyloscripts/tree/master/phypartspiecharts) 

Indicate the path to ete3 (example in trichopilia):
```
export PATH=/home/sidonie/anaconda_ete/bin:$PATH
```
Run the script:
```
xvfb-run python sidonie/softwares/phypartspiecharts_MJohnson.py species_tree.tre phyparts-out/out-prefix gene-number
```
The ""xvfb-run" is sometimes necessary if you run it remotely, but not needed if you run it locally (for instance if you installed ete3 on your computer).
  
### Make piecharts corresponding to the Astral support

We have scripts to generate piecharts based on ASTRAL local posterior probabilities, or quartet support.  
Example:
```
xvfb-run python test-ete.py species_tree.tre
```

### Support interpretation for phyparts 
From [S. Smith](https://bitbucket.org/blackrim/phyparts) and [M. Johnson](https://github.com/mossmatters/phyloscripts/tree/master/phypartspiecharts) websites, and assuming no change in colors from M. Johnson's original script:  
  
Blue: Support the shown topology = percentage of gene trees concordant with the shown topology  
Green: Conflict with the shown topology (most common conflicting bipartion) = percentage of gene trees showing the most common conflicting topology  
Red: Conflict with the shown topology (all other supported conflicting bipartitions) = percentage of gene trees showing any other conflicting topology  
Gray: Have no support for conflicting bipartion = percentage of gene trees showing neither support nor conflict with the shown topology due to low bootstrap support ("low" being what you set up during phyparts analysis)  
Numbers above branches: number of gene trees concordant with the shown topology (blue)  
Number below branches: number of gene trees conflicting with the shown topology (red + green)  

### Support interpretation for the direct output of Astral 

Look at [S. Mirarab](https://github.com/smirarab/ASTRAL/blob/master/astral-tutorial.md#branch-length-and-support) website.


