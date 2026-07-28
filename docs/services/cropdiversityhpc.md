# Crop Diversity HPC

Kew staff have access to the Crop Diversity HPC for data processing and analysis. For more information visit their help pages: [help.cropdiversity.ac.uk](https://help.cropdiversity.ac.uk/index.html)

## What is HPC
High Performance Computing (HPC) is the use of large clusters of computers to process huge amounts of data with high throughput. This has typically been the use of multiple CPUs via clustering, but now also includes high core count CPUs and GPUs.

The strengths of HPC over your desktop or laptop computer:

- [Parallel Processing](../tutorials/parallel.md]) : The primary benefit of HPC
- Memory Capacity: much more available so whole data sets can be analysed much faster than on disk
- Paralellised storage: The same data can be accesed by many processes at once

Where HPC isn't nesssicarily better:

- CPU core speed: single core performance may even be lower than high-end desktop CPUs
- Latency: Jobs are sent to a queue and don't always run imedialty

## Access

To get an account on the Crop Diversity HPC fill in the form here: [help.cropdiversity.ac.uk/user-accounts.html](https://help.cropdiversity.ac.uk/user-accounts.html)

Once you recieve your username and temorary password you can then login via ssh while on site at Kew or Wakeurst. For access offsite you need to have key pair authentication with 2FA set up. More details here: [help.cropdiversity.ac.uk/ssh.html](https://help.cropdiversity.ac.uk/ssh.html)

## Transferring Data

There are several ways of transfering data to the Crop Diversity HPC:

- [rsync](https://help.cropdiversity.ac.uk/file-transfers.html#rsync)
- [scp](https://help.cropdiversity.ac.uk/file-transfers.html#scp)
- [sftp](../tutorials/sftp.md)

