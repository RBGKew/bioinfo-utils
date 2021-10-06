# GATK

GATK (Genome Analysis ToolKit) is a collection of tools maintained by the Broad Institute for analysing NGS data.

# How to use on KewHPC

To use GATK first load the module 

	module load gatk/4.2.0.0

Then activate the conda environment. If you've not used conda before initialise it as described [here](./software/anaconda.md)

	conda activate gatk

do deactivate the conda environment:

	conda deactivate

Now you can see the available tools:
	
	gatk --list
