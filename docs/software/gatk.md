# GATK

GATK (Genome Analysis ToolKit) is a collecton of tools maintained by the Broad Institute for analysinmg NGS data.

# How to use on KewHPC

To use GATK first load the module 

	module load gatk/4.2.0.0

Then activate the conda environment. If you've not used conda before initalise it as described [here](./software/anaconda.md)

	source activate gatk

do deactivate the conda environment:

	source deactivate

Now you can see the available tools:
	
	gatk --list

