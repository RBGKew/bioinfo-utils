# Some Tips for Using the PAFTOL / Kew Cluster

The purpose of these tips is to help you getting the most of the
cluster, by helping you to design and conduct your analyses to get you
valid results, and to get them efficiently and quickly.


## Plan and Prepare Your Analysis

This is based on research question and inferring from that which data
and analysis techniques (computational and otherwise) you need to
answer it, so you probably have done a good part of this already.
Typically this involves checking literature and documentation of the
software you use and checking that all prerequisites for a valid
analysis are met.

Scientific criteria are most fundamental, and they largely depend on
your specific research project or question. One general thing to keep
in mind when surveying software options is that the most adequate
software is often not described as suitable to your specific purpose.
This is because your research question is new -- so nobody, including
the authors of the software, has thought about this specific use.
Therefore, breaking up your analysis into small and generic
operations, and finding a piece of software to carry out each of
these, will frequently be a more efficient way to find the software
you need. Or, in other words, software designed for a narrow, specific
use case is suitable only if your requirements fall into that scope.
Otherwise, committing to using that sofware all too often results in
unnecessary compromise scientifically, while at the same time causing
a lot of entirely avoidable technical hassle and awkwardness.

At the technical level, some considerations apply to almost all
analyses. These include:

* checking that input data is complete,

* ensuring that input data is in a consistent and suitable format,

* where you run multiple programs in a "pipeline", verify that the
  output format of each program is suitable as input for the
  subsequent program.

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
won't. Therefore, make some copies of your pilot data at various
stages of your analysis, change them, predict the effect of these
changes on your results, and test whether your expectations are right.
Importantly, include some changes that make your data invalid or
corrupt. Getting some impression of how your software behaves when
things are not quite right will greatly help you to troubleshoot
problems later, and even more importantly, to spot tell-tale signs of
problems in the first place.

Exploring and getting to know your software is different from
exploring and analysing your data, and the importance of knowing your
software can hardly be overstated. It really is an aspect of the
general scientific discipline of being sceptical, aware of all
possible states and conditions, and being unbiased. Prematurely
focusing on data analysis can result in becoming biased towards
initial result, especially if they are consistent with expectations or
hopes, and sometimes even result in perceiving genuine but less
favourable evidence as results of software flaws or bugs. Knowing your
software _per se_ is an excellent way to protect against walking into
such traps.


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

* Exponential complexity: Forget it (unless you can use really very small values of **n**).


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
`rbg-kew-bioinformatics@googlegroups.com`

The main purpose is to find out the characteristics of computing time
as a function of input size, not the absolute times. Therefore, you
can use any machine, including the legacy Linux boxes or a docker
container running on your laptop, for this type of test. Once you know
this characteristic, working out the expected absolute computing time
on the cluster is a matter of multiplication with a constant.


## Explore Parallelisation

Many computational processes can be parallelised. Some benefit greatly
from that (these are the highly scalable ones), while with others,
benefits are much more limited. A full discussion of theory and
programming principles behind this are beyond the scope here. It is,
however, a very common phenomenon to find that programs benefit from
parallelisation up to some point, but benefits diminish beyond that
point.

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
to estimate how long it will take as a function of the number of cores
you request.

If you only need a small fraction of the cores on the cluster, just go
ahead and submit your job. At the time of writing this, we have 2
nodes with 88 cores each and use the `slurm` queue management system,
so requesting up to 22 CPUs in a one-task job is probably ok. If you
need more resources, it's a good idea to check the general load of the
cluster and to get in touch with the cluster user community.

Good luck with your analysis. If you have any suggestions to improve
or add to these tips, general questions, and interesting results and
experiences to share, please join us on Tuesdays, 11:00, for Biscuits
& Bioinformatics in the Jodrell coffee room.
