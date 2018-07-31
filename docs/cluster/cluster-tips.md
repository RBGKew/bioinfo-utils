# Some Tips for Using the PAFTOL / Kew Cluster

The purpose of these tips is to help you getting the most of the
cluster, by helping you to design and conduct your analyses so that
you efficiently get results that are valid and also reproducible.


## Plan and Prepare Your Analysis

This is really a prerequisite to ensure getting a scientifically valid
result, so you probably have done a good part of this already.
Typically this involves checking literature and documentation of the
software you use and checking that all prerequisites for a valid
analysis are met. Scientific criteria are most fundamental, and they
depend on your specific research project or question and therefore
cannot be addressed by generic tips. However, some technical
considerations apply to almost all analyses. These include:

* checking that input data is complete

* ensuring that input data is in a consistent and suitable format

* where you run multiple programs in a "pipeline", verify that the
  output format of each program is suitable as input for the
  subsequent program

For all these checks, formal specs are preferable to trying things out
and finding they work.


## Familiarise Yourself With Your Software

Having established your analysis plan and prerequisites, get yourself
an example or pilot data set and carry out the analysis process
manually and step by step. Keep your pilot data small, so you can move
through this stage quickly; if you find yourself waiting for lengthy
analyses to complete at this stage, make your pilot data smaller.

Once you have initially worked through all steps, resist the
temptation to assume that this is how things will always work. They
won't. Therefore, introduce some errors or problems into copies of
your pilot data at various stages of your analysis, and find out how
that affects the process. Getting some impression of how your software
behaves when things are not quite right will greatly help you to
troubleshoot problems later, and even more importantly, to spot
tell-tale signs of problems in the first place.


## Get an Idea of Algorithmic Complexity

This is the first stage of developing informed estimates of run times.
There are only a few complexity categories that really matter:

* **O(n)**, i.e. linear: This is the best case.

* **O(n * log(n))**: This is quite ok, but you'll need to be more
  careful when ramping up the size of your jobs.

* **O(n * n)**, i.e. quadratic: This approaches the limits of
  feasibility; increasing problem sizes will very noticeably
  increase computing times

* Complexity of higher polynomial degree: Rare, use extreme caution.

* Exponential complexity: Forget it.


## Series of Small Tests That Increase in Size

This is to cross-check your ideas about algorithmic complexity. Set up
a small series of inputs of increasing size and measure the CPU time
that requires. The `/usr/bin/time` program is useful at this stage,
especially the `%U` conversion.

As an example, this script generates random sequences of lenghts
10,000 to 50,000 in increments of 10,000 using the EMBOSS `makenucseq`
application, then uses `msbar` to make a "mutated" variant of each,
and finally aligns the two using `water`, using `/usr/bin/time` to
collect computing times in a file:

```
rm -f watertime.txt
for seqLength in 10000 20000 30000 40000 50000 ; do
    makenucseq -amount 1 -length $seqLength -stdout  -osdbname dbname -auto | sed -e "s/>.*/rndseq${seqLength}a/" > "rndseq${seqLength}a.fasta"
    msbar -count 1000 -point 4 -sequence "rndseq${seqLength}a.fasta" -stdout -auto | sed -e "s/>.*/rndseq${seqLength}b/" > "rndseq${seqLength}b.fasta"
    /usr/bin/time -f '%U' -a -o watertime.txt water -asequence "rndseq${seqLength}a.fasta" -bsequence "rndseq${seqLength}a.fasta" -outfile "water${seqLength}.txt" -auto
done
```
Try plotting the values in `watertime.txt`, e.g. with `R`. Considering
the dynamic programming algorithm for pairwise alignment, you may have
expected the parabola shape.

If your findings here are inconsistent with your expectations based on
algorithmic complexity, check what's going on, e.g. by reviewing
relevant literature and documentation, or by emailing your local
bioinformatics community at
`rbg-kew-bioinformatics+noreply@googlegroups.com`

For this type of test you can use any machine, including the legacy
Linux boxes or using a docker container running on your laptop, as the
main purpose is to find out the characteristics of computing time as a
function of input size, not the absolute times. Once you know this
characteristic, working out the expected absolute computing time on
the cluster is a matter of multiplication with a constant.


## Explore Parallelisation

Many computational processes can be parallelised. Some benefit greatly
from that, while others don't at all. Any further discussion of theory
and programming principles behind this are beyond the scope here. It
is, however, a very common phenomenon to find that programs benefit
from parallelisation up to some point, but benefits diminish beyond
that point.

The most common way of specifying the amount of parallelism is by
giving programs a number of threads that they should use. Typically,
this is done via the command line. As an example, the `bwa` program
provides the `-t` option for this purpose. Here's a fully worked
script to explore the benefit of multithreading with `bwa`:

```
rm -rf bwatime.txt
bwa index test_targets.fasta
for numThreads in 1 2 3 4 5 6 7 8 9 ; do
    /usr/bin/time -f '%e,%U' -a -o bwatime.txt bwa mem -t "$numThreads" test_targets.fasta EG30_R1_test.fastq EG30_R2_test.fastq > "test_targets-EG30-t${numThreads}.sam"
    echo $numThreads done
done
```

The files `test_targets.fasta`, `EG30_R1_test.fastq` and
`EG30_R2_test.fastq` are from Matt Johnson's [HybPiper
Tutorial](https://github.com/mossmatters/HybPiper/wiki/Tutorial). On
my desktop machine, the results of this test quite clearly indicate
that benefits diminish beyond 4 threads:

```
$ cat bwatime.txt
11.68,11.18
6.10,11.10
4.33,11.24
4.06,11.21
3.84,11.15
3.47,11.12
4.48,11.30
4.02,11.25
3.75,11.17
```

The explanation for this is that my desktop machine has a quad-core
CPU. So differently from the previous test of total CPU time (which
stays the same regardless of multithreading, as shown by the
experiment above), repeating this test on the cluster makes sense.
Just be sure to use _small_ test data sets, please.


## Ready to Run

Having carried out these preparations, you should have a basis to
expect your analysis process to yield valid results, and a good handle
to estimate how long it will take. So go ahead and submit your job --
at the time of writing this, the `slurm` queueing system is the
mechanism provided to do that.

Good luck with your analysis, and please let us know if you have any
suggestions to improve or add to these tips.
