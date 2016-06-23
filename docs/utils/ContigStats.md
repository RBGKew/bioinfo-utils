# Assembly contig stats script

## Ported from [Mycology tools wiki](http://mycologywiki.kew.org/mycology/index.php/Assembly_contig_stats), 23/June/2016

### NAME

ContigStats.pl version 2, 4 May 2011

### SYNOPSIS

```ContigStats.pl -i sequence file [-f format] [-l]```

### DESCRIPTION

Gives N50, max contig, total length, and number of contigs for a genome assembly.
Rewritten to allow calculation for subsets of the sequences (see info above @first_seqs).

Options:
      -f file format (guessed form extension if not provided)
      -m minimum contig length
      -g include gap characters inserted between contigs in scaffolds

### AUTHOR

 Heath E. O'Brien <heath.obrien-at-utoronto-dot-ca>

```
#ContigStats.pl
#Heath O'Brien
#25 May 2010
#
#Gives N50, max contig, total length, and number of contigs for a genome assembly
```