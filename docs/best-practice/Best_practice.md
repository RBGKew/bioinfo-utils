# Best practice

(These are procedures that should be followed when using RBG Kew bioinformatics resources)

---

## Git repositories

Git repositories for your own development work should be installed in your /home/<user> space, or /mnt/HDD_2/<user> if they contain large data files (not the best idea ever, but they might...)

Git repos that contain scripts everyone is likely to want to use / modify (such as these bioinf-utils, for instance) should be stored in /usr/local/bioinf/git-repositories

---

## Machine install logs

When you make significant updates to a machine (installing software, including version changes, and/or BLAST DBs etc) *please* log those changes in the machine specific notes in the github. You can do this online at e.g. https://github.com/RBGKew/bioinf-utils/tree/master/docs/machines *or* edit the the .md files directly in the git repo. For most machines this will be found at: /usr/local/bioinf/git-repositories/bioinfo-utils/docs/machines/

---

## Shutdown notices

*ALWAYS* issue a shutdown notice / warning message (`man shutdown`) in advance of a system shutdown, if you have to do so. If you need to rapidly, please at least check the jobs logging system (see also https://github.com/RBGKew/bioinfo-utils/blob/master/docs/utils/logging-jobs/index.md) for that machine, use `htop` to further check what's running, and attempt to contact users with running jobs before shutting down!

---

## Jobs logging

Jobs that are using a significant fraction of system resources (more than 50%, say) and/or likely to take more than a few hours *must* be logged using the i-want-a-jobby scripts (see http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/utils/logging-jobs/) in all cases.

---

## Where Should I Install Software

In most cases, bioinformatics software should be installed under:
```
/usr/local/bioinf/<package>
```
Any executable binaries should be copied/placed into:
```
/usr/local/bioinf/bin/<package_executable>
```
`/usr/local/bioinf/bin/` can then be added to your `$PATH`, for instance using `~/.bash_profile` if you use `/bin/bash` as your main shell (see `man chsh` for notes on changing your shell)
 
---

## Where Should I Put My Data?

*ALWAYS BACK UP YOUR DATA*

You should *always* put any significant research data under `/mnt/HDD_<n>/<user>` (e.g. `/mnt/HDD_2/joe` etc). This is so that we can keep track of disk space efficiently and leave the machines with sufficient scratch space for analyses.

Note that although the devices mounted under `/mnt/HDD_2|/mnt/HDD_3` are separate physical drives on these machines, they should *not* be considered your primary backup, rather an additional bonus copy. Back your *valuable research data up - you have been warned!*.

*NEVER* store significant data under `/home/<user` (e.g. `/home/joe`) as this makes it very hard for us to keep track of disk space, badger management for more disks, manage backups, and all the other boring crap...

---

## Where Are BLAST Databases Placed?

Please place custom databases for your personal use in:
```
/mnt/HDD_2/blast_db
```
(Note that this is the only time 'personal' data would go anywhere other than `/mnt/HDD_2/<user>`. This is so that we can keep track of which BLAST databases have been made and avoid duplicates wherever possible.)

Local mirrors of the main NCBI/ENA/DDBJ (INSDC) datasets (nr, nt and refseq) can be found on Arisaema *only* under `/usr/local/bioinf/blastdb`. Since these are updated by INSDC every other month (even-numbered months) we will try to update (potentially using update_blastdb.pl; see https://www.ncbi.nlm.nih.gov/books/NBK52640/ for more) on odd-numbered months. Please log BLAST DB updates to the machine file for Arisaema, which you can read at: http://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/machines/Arisaema/ and edit on the web at https://github.com/RBGKew/bioinfo-utils/blob/master/docs/machines/Arisaema.md or on the machine itself at `/usr/local/bioinf/git-repositories/bioinfo-utils/docs/machines/Arisaema.md`.

