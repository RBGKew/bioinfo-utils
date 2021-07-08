#Anaconda

Anaconda is a package management tool which can be used to setup python, R and many other environments with a wide range of libraries and modules need.

## First Use

To start using conda:

	module load anaconda/2020.11
	conda init

Then log out of kewhpc and back in. This adds several lines to your .bashrc which can be removed by deleting them, If you no longer want to use conda.

You should now see "(base)" before your username at the command prompt.


## Creating and Switching Environments

To load the conda environment I've made move the attached .yml file to your pwd and run:

	conda env create -n my_env

To load the "my_env" environment use:

	conda activate my_env

and to move back to the "base" environment:

	conda deactivate

for more help see the annaconda [user guide](https://docs.anaconda.com/anacondaorg/user-guide/)