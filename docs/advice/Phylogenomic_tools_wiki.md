
# ILLUMINA DATA PIPELINE
---

## RAW FASTQ HANDLING AND ADAPTER TRIMMING
1) concatenate same-direction reads if in multiple files <span style="color:#DC143C">*N.B. make sure the paired reads are in the same sequence in both files!*</span>
```
$cat file1_1.fq file2_1.fq > file_1.fq | cat file1_2.fq file2_2.fq > file_2.fq
```
2) trim using [Trimmomatic](http://www.usadellab.org/cms/index.php?page=trimmomatic) *N.B. this is probably unnecessary if assembling with ABySS, which models and deals with sequencing errors* (see [Del Fabbro C, Scalabrin S, Morgante M, Giorgi FM (2013) An Extensive Evaluation of Read Trimming Effects on Illumina NGS Data Analysis. PLoS ONE 8(12): e85024.](http://dx.doi.org/10.1371/journal.pone.0085024))
```
$cd directory_where_trimmomatic_resides
$java -jar Trimmomatic-0.32.jar PE -threads 24 -phred33 -trimlog logfile_name path_to_paired_end_forward_read_file/file_1.fq /path_to_paired_end_reverse_read_file/file_2.fq forward_paired_trimmed.fq.gz forward_unpaired_trimmed.fq.gz reverse_paired_trimmed.fq.gz reverse_unpaired_trimmed.fq.gz ILLUMINACLIP:./adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
```
3) merge PE reads
4) split PE reads from merged file
```
$grep '@.\*1:N' -A 3 merged.fastq > read.1.fastq
$grep '@.\*2:N' -A 3 merged.fastq > read.2.fastq
```
N.B. for OS X users, install GNU grep first: brew tap homebrew/dupes; brew install grep
Then use:
```
# NOTE
# Joe Parker, 2016-06-23
# Command below ('ggrep') looks like a typo but I've imported from Bryn's wiki *without* correcting it.
$ggrep '@.\*1:N' -A 3 --no-group-separator merged.fastq > read.1.fastq
```
5) convert fastq to fasta
```
$cat file.fastq | perl -e '$i=0;while(<>){if(/^@/&&$i==0){s/^@/>/;print;}elsif($i==1){print;$i=-3}$i++;}' > file.fasta
```
6) extract seqs from fastq using list of headers (N.B. requires seqtk: $brew install seqtk)
```
$seqtk subseq filename_merged.fastq file.list > filename.fastq
```

## ASSEMBLY OF PAIRED-END ILLUMINA READS
---

1) assemble with ABySS (http://www.bcgsc.ca/platform/bioinfo/software/abyss) (k=31 as default best compromise -- could be determined empirically) **N.B. the order of the options is important!**
```
$abyss-pe np=24 k=31 name=path_to_file/filename in='path_to_paired_end_forward_read_file/file_1.fq path_to_paired_end_reverse_read_file/file_2.fq'
```
2) assemble multiple libraries with ABySS **N.B. must use ```'``` symbol not ```‘``` symbol!!!!**
```
$abyss-pe np=24 k=31 lib='hiseq miseq' hiseq='HiSeq_1.fq HiSeq_2.fq' miseq='MiSeq_1.fq MiSeq_2.fq' name=combined
```

### FILTERING OUT SHORT CONTIGS

An easy one-liner using [bioawk](https://github.com/lh3/bioawk) (```$brew install bioawk```) to keep contigs >500:
```
$bioawk -c fastx '{ if(length($seq) > 500) { print ">"$name; print $seq }}' input_file > output_file
```

### ALIGNING READS BACK TO CONTIGS USING BOWTIE2

First, generate an index:
```
$bowtie2-build file.fa outfile_handle
```

Then, align the reads to the contigs (this is for paired-end sequences):
```
$bowtie2 -p 24 -x outfile_handle -1 forward_read.fq -2 reverse_read.fq -S outfile.sam
```

### CONVERTING SAM TO BAM, SORTING, AND INDEXING

Convert SAM to BAM:
```
$samtools view -bS file.sam > file.bam
```

Sort the contigs:
```
$samtools sort file.bam file.sorted
```

Index the file:
```
$samtools index file.sorted.bam
```
---

## USING PILON TO IMPROVE ASSEMBLY AND VARIANT CALLING

Pilon was developed by the Broad Institute to improve assemblies of short reads and for improved variant detection. See [Walker et al. (2014)](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0112963).

Pilon can be downloaded [from GitHub](<https://github.com/broadinstitute/pilon/releases)

Use bowtie2 and samtools to first align reads to the contigs (see above). Pilon runs under java. Here the RAM is at 32GB. No less than 8GB is required, and 16GB is recommended.
```
$java -Xmx32G -jar pilon-1.12.jar --genome genome.fa --frags file.sorted.bam
```
---

## GENE PREDICTION

1) gene prediction using [AUGUSTUS](http://bioinf.uni-greifswald.de/augustus/) **INSTALLING AUGUSTUS ON OS X 10.9 MAVERICKS ---DOES NOT WORK! TRY INSTALLING ON LINUX USING VIRTUAL BOX OR TUNNELLING INTO LINUX MACHINES IN JODRELL (e.g., ssh -lguest x.x.8.93)**
```
$augustus --species=coprinus path-to-infile/infile.fa > path-to-outfile/outfile.gff
```

## SECONDARY METABOLITE GENE CLUSTER ANALYSIS

1) [antiSMASH] (http://antismash.secondarymetabolites.org)

---
## ALIGNMENT FOR PHYLOGENOMICS

1) contig reordering to a reference (i.e. well-annotated reference genome or an outgroup in a phylogenetic dataset) using [MAUVE](http://gel.ahabs.wisc.edu/mauve/)
e.g.,
```
$java -Xmx24000m -cp /Volumes/RAID_Set_1/MAUVE/Mauve.app/Contents/Resources/Java/Mauve.jar org.gel.mauve.contigs.ContigOrderer -output Hygrocybe_reorder -ref /Volumes/RAID_Set_1/Agaricales_Genomes/Boletus_ed1_AssemblyScaffolds_Repeatmasked.fasta -draft /Volumes/RAID_Set_1/Agaricales_Genomes/Hygrocybe_scaffolds_2000_include.fa
```

---
## Other tips
### PROXY PROBLEMS

change the proxy setting for homebrew, etc.:
```
$export http_proxy=http://USERNAME:PASSWORD@proxy.ad.kew.org:8080
$export ALL_PROXY=$http_proxy
```
change the proxy setting for ftp, incl. ncbi:
```
$export ftp_proxy=ftp://USERNAME:PASSWORD@proxy.ad.kew.org:8080
$export ALL_PROXY=$ftp_proxy
```
for github issues, change the git config (username = e.g., zz99kg):
```
$git config --global http.proxy http://USERNAME:PASSWORD@proxy.ad.kew.org:8080
```
Trouble with wget? Try curl:
```
$curl ftp://someftpsite -o filename
```

### SOME HANDY SCRIPTS
- [assembly contig stats](../utils/ContigStats.pl) (courtesy of Heath O'Brien)
- <a href=https://github.com/hobrien/Perl/blob/master/ParseBlast.py>ParseBlast.py</a> (courtesy of Heath O'Brien)
This will identify the query sequence with the highest bitscore for each subject sequence. For tblastn searches, it will extract the subject sequences for each hsp from this query / subject pair, translate them and concatinate them (separated by an 'X'). For blastp searches it will simply extract the sequences and names them according to the top query sequence. At the moment, it does not work with other kinds of blast searches, but it could easily be extended.
