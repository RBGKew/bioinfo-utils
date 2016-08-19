# Script to print two random words

## Description:
        Print two (pseudo) random words from the /usr/share/dict/words wordlist
        An adapted version of this would also be useful for e.g. printing random lines from a fasta or pa 
 
## Author:
	joe.parker@kew.org @lonelyjoeparker
 
## Date: 
       16 Aug 2016
 
## Usage: 
       ./print_two_pseudorandom_words.sh
 
## Output:
       two pseudorandomly selected words from /usr/share/dict/words, space-delimited
 

```bash
#! /bin/bash

# Description:
#	Print two (pseudo) random words from the /usr/share/dict/words wordlist
#	An adapted version of this would also be useful for e.g. printing random lines from a fasta or paml file
#
#
# Author: 
#	joe.parker@kew.org @lonelyjoeparker
#
# Date: 
#	16 Aug 2016
#
# Usage: 
#	./print_two_pseudorandom_words.sh
#
# Output:
#	two pseudorandomly selected words from /usr/share/dict/words, space-delimited

#get two random numbers using builtin $RANDOM (actually pseudorandom only)
word_1=$(expr $RANDOM + $RANDOM + $RANDOM + $RANDOM + $RANDOM + $RANDOM + $RANDOM) #each RANDOM val [0-32767], around 7* as many words in wordlist, so 7 added rands to get the necessary range
word_2=$(expr $RANDOM + $RANDOM + $RANDOM + $RANDOM + $RANDOM + $RANDOM + $RANDOM) 

#concat to make sed-friendly arg (e.g. `sed -n '10p' <somefile` prints 10th line in <somefile>
which_word_1="${word_1}p"
which_word_2="${word_2}p"

#ask sed to get n1th and n2th lines 
echo `sed -n ${which_word_1} </usr/share/dict/words` `sed -n ${which_word_2} </usr/share/dict/words`
```
