# Utils		

This is the place to put utility scripts - they can be submitted as a single script in this directory if they are a single file (otherwise a subdirectory with the same name as the script). Check here first before writing new scripts of your own to perform simple tasks - someone may well have written one already!

When writing scripts, try to Keep It Simple. Try to break a complex task into smaller subunits and write good robust code for each part, unless global variables are absolutely essential. Here's an example - instead of this:

```
#myMassiveProgram

function_one{
	# do something
}

function_one{
	# do something
}

function_one{
	# do something
}
```

Break the task up, e.g. instead of `function_one()` use `script_one`. Then the separate functions can still be simply chained together with e.g. `cat some_input.fa | script_one | script_two | script_three > outfile.fa`. This allows functions to be recombined or improved much more readily.

General instructions, advice, best practice etc can be found in the [docs](../docs) folder.		

## Correct documentation		

To be useful to others, it is important that scripts placed here are well documented enough that someone can use them without detailed instructions from 
you!

Please make sure that **all scripts are well-documented** and that where appropriate **attributed correctly** (e.g. if you have forked or developed code from elsewhere on the web, make sure the source attribution / license are observed)!		

At a minimum **all** scripts here should have the following:		

* A sensible, informative name		
* Basic usage information in the script header itself:				
  * What the script does		
  * Any arguments that are expected		
* A boilerplate usage document in Markdown format with the same name, e.g `extract_fasta.py` with a corresponding `extract_fasta.md`

## General advice

See:

1. [Dudley &amp; Butte, 2009](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2791169/)

