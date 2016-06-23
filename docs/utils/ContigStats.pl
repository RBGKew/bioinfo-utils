#!/usr/bin/perl -w

=head1 NAME

ContigStats.pl version 2, 4 May 2011

=head1 SYNOPSIS

ContigStats.pl -i sequence file [-f format] [-l]

=head1 DESCRIPTION

Gives N50, max contig, total length, and number of contigs for a genome assembly.
Rewritten to allow calculation for subsets of the sequences (see info above @first_seqs).

Options:
      -f file format (guessed form extension if not provided)
      -m minimum contig length
      -g include gap characters inserted between contigs in scaffolds

=head1 AUTHOR

 Heath E. O'Brien E<lt>heath.obrien-at-utoronto-dot-caE<gt>

=cut

#ContigStats.pl
#Heath O'Brien
#25 May 2010

=head

Gives N50, max contig, total length, and number of contigs for a genome assembly
=cut

####################################################################################################

use warnings;
use strict;
use Bio::SeqIO;
use Getopt::Long;

#Read in command line arguments
my $format;
my $filename;
my $help =0;
my $min_length = 1;
my $include_gaps = 0;
my $print_cumulative = 0;
Getopt::Long::Configure ("bundling");
GetOptions(
'f|format:s' => \$format,
'i|in:s' => \$filename,
'm|min:s' => \$min_length,
'g|gaps' => \$include_gaps,
'c|cumulative' => \$print_cumulative,
'h|help|?' => \$help,

);

my $USAGE = "type perldoc ContigStats.pl for help\n";
if( $help ) {
    die $USAGE;
}

$filename = shift unless $filename;

unless ( $filename ) { die "filename not specified $USAGE\n"; }
unless (-e $filename ) { die "$filename: no such file\n"; }

unless ($format) {
  $filename =~ /(\.[^.]+)$/;
  $format = GetFormat($1);
}

####################################################################################################
#Read in info about sequences
my $seqfile = Bio::SeqIO->new(-format => $format,
                           -file   => $filename) or die "no such file";

my @seqlengths;
my $gap_length = 0;
my $gap_num = 0;
#read sequences, assign them to size classes, and modify total size of classes
while (my $seq = $seqfile->next_seq) {
  my $seqstring = $seq->seq;
  #if ( length($seqstring) < 100 ) { print ">", $seq->display_id, "\n$seqstring\n"; }
  if ( $include_gaps and length($seqstring) >= $min_length) { push(@seqlengths, length($seqstring)); }
  while ( $seqstring =~ s/(N+)//i ) {
    $gap_num ++;
    $gap_length += length($1);
  }
  unless ( $include_gaps or length($seqstring) < $min_length ) {push(@seqlengths, length($seqstring)); }
}
@seqlengths = sort { $b <=> $a } @seqlengths;
my $num_contigs = scalar(@seqlengths);
my $max_contig = $seqlengths[0];
my $min_contig = $seqlengths[-1];
my $total_length = 0;
my $cumulative_length = 0;
my $x = 0;
foreach (@seqlengths) {
  $total_length += $_;
}
foreach (@seqlengths) {
  $cumulative_length += $_;
  if ( $print_cumulative ) { print "$cumulative_length\n"; }
  if ( $cumulative_length < ($total_length / 2) ) { $x ++; }
}
unless ( $print_cumulative ) {
  my $n50 = $seqlengths[$x-1];
  my $average = int(($total_length / $num_contigs)+0.5);
  my $HRn50 = $n50;
  $HRn50 =~ s/(^[-+]?\d+?(?=(?>(?:\d{3})+)(?!\d))|\G\d{3}(?=\d))/$1,/g;
  my $HRnum_contigs = $num_contigs;
  $HRnum_contigs =~ s/(^[-+]?\d+?(?=(?>(?:\d{3})+)(?!\d))|\G\d{3}(?=\d))/$1,/g;
  my $HRmax_contig = $max_contig;
  $HRmax_contig =~ s/(^[-+]?\d+?(?=(?>(?:\d{3})+)(?!\d))|\G\d{3}(?=\d))/$1,/g;
  my $HRtotal_length = $total_length;
  $HRtotal_length =~ s/(^[-+]?\d+?(?=(?>(?:\d{3})+)(?!\d))|\G\d{3}(?=\d))/$1,/g;
  my $HRaverage = $average;
  $HRaverage =~ s/(^[-+]?\d+?(?=(?>(?:\d{3})+)(?!\d))|\G\d{3}(?=\d))/$1,/g;
  my $HRgap_num = $gap_num;
  $HRgap_num =~ s/(^[-+]?\d+?(?=(?>(?:\d{3})+)(?!\d))|\G\d{3}(?=\d))/$1,/g;
  my $HRgap_length = $gap_length;
  $HRgap_length =~ s/(^[-+]?\d+?(?=(?>(?:\d{3})+)(?!\d))|\G\d{3}(?=\d))/$1,/g;  
  print "N50: $HRn50\n#contigs: $HRnum_contigs\nMax_contig: $HRmax_contig\n";
  print "Min_contig: $min_contig\nTotal_length: $HRtotal_length\nAverage_contig: $HRaverage\n";
  print "Num_gaps: $HRgap_num\nTotal_gap_length: $HRgap_length\n";
}


###################################################################################################
sub get_clc_id {
    my $header = shift;
    $header =~ /[Cc]ontig ?(\d+)/;
    return "Contig_$1";
}

sub GetFormat {
  my $ext = shift;
  my $format;
  if ( $ext =~ /f.*q/i ) { $format = "fastq";}
  elsif ( $ext =~ /^\.fa*/i ) { $format = "fasta";}
  elsif ( $ext =~ /xmfa/i ) { $format = "xmfa";}
  elsif ( $ext =~ /phy/i ) { $format = "phylip";}
  elsif ( $ext =~ /aln/i ) { $format = "clustalw";}
  elsif ( $ext =~ /gb/i ) { $format =  "genbank";}
  elsif ( $ext =~ /nxs/i ) { $format =  "nexus";}
  elsif ( $ext =~ /nex/i ) { $format =  "nexus";}
  elsif ( $ext =~ /maf/i ) { $format =  "maf";}
  elsif ( $ext =~ /txt/i ) { $format = "snp_tbl";}
  else {die "extension not recognized!";}
  return $format;
}