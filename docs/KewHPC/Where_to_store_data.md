
## Data Storage
There are 3 main places you can store your data /home, /data and /science.

| Location | Size | Speed | Usage | Availability | Redundancy |
|----------|------|-------|-------|--------------|-------------|
| /home | 10GB per user | Fast | Config files, scripts and documents | login01, node001-012, hmem01-02 | Not backed up, keep a copy of scripts on your local machine or on /science |
| /data | 340TB Total | Fast | Data and scripts for jobs running on KewHPC | login01, node001-012, hmem01-02 | Not backed up, keep a copy of irreplaceable data on /science |
| /science | 139TB Total | Slower | Data and scripts not currently in use, but which need keeping accessible | login01 | Snap-shotted with a mirror at the Wakehurst site |

There are 2 main areas in /data and /science.

### projects
For data shared for a specific project. 
To access an existing group or to request a new project directory and group you need to contact [Matt Clarke](mailto:m.clarke@kew.org) and get permission form the groups owner (usually the associated team leader).

### users_area
A place for an individual user to run analyses (in the case of /data/users_area) and store data only needed by them.

