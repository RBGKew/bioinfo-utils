# R
There are 2 version of R installed on KewHPC are 3.6.3 and 4.0.2

## Installed Modules 

Many commonly used R moules have been centrally installed. If you need any others ask [Matt Clarke](mailto: m.clarke@kew.org) to install them centrally, or install to a personal local lib in your /data/users_area/ directory.  


## Installing Modules to Local Library

You can install packages locally in your /data/users_area or /home. This is especially useful if you need a specific version or are developing an R module.

### Installing to Local Lib

Load up the version of R you need and enter the interactive R terminal.

	module load R/3.6.3
	R

Specify the location of your local library with "lib=".

	install.packages("ggplot2",lib="/data/users_area/usr00kg/R_local_lib")
	

### Loading from Local Lib

There are two ways of doing this:

#### Permanently Loading the Lib
 This is done by adding your library to the "R_LIBS" variable by adding the following lines to the end of your ~/.bashrc file.

	if [ -n $R_LIBS ]; then
		export R_LIBS=/data/users_area/usr00kg/R_local_lib:$R_LIBS
	else
		export R_LIBS=/data/users_area/usr00kg/R_local_lib
	fi

#### Within Your R script

By specifying the library when loading the library

	library("ggplot2", lib.loc="/data/users_area/usr00kg/R_local_lib")



