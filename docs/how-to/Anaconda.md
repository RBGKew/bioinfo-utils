# Anaconda on the Cluster

Anaconda is a tool for creating and managing python environments.
Learn more at https://docs.anaconda.com/anaconda-cloud/user-guide/

---
## first use

The first time you use anaconda you have to run the following commands:

	cat /science/software/src/add_anaconda.txt >> ~/.bashrc

Create a folder in which your conda environments will be stored

	mkdir /science/users_area/your_user_name/conda_envs
	echo "export CONDA_ENVS_PATH=/science/users_area/your_user_name/conda_envs:/science/software/anaconda2/envs" >> ~/.bashrc

to enact these changes either log out and back in or run this command:

	source ~/.bashrc

## activating and deactivating environments

some environments are preinstalled for spcific tools
To activate:

	conda activate conda_env_name

To deactivate:
	
	conda deactivate


---

## creating environments

con

