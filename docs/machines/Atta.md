# Atta1 / Atta2

## Basic info

Atta1 and Atta2 are medium-capacity genomics clusters implementing SLURM for job submission and management.

They are notionally identical (hardware/firmware/OS) although environments are configured differently in some respects (e.g. software availability, etc).

## README

These are detailed information about each available machine. **DO NOT** put passwords, keypair locations or other sensitive information on these pages - they are public!

## Basic info

Name on network | IP  | Name | Total RAM(GB) | Total cores vCPU | Notes
--------------- | --- | ---- | ------------- | ---------------- | -----
atta1.ad.kew.org | x.x.x.x | Atta2 | ~4000 | ~120 | Prinicpally BLAST, Kraken
atta2.ad.kew.org | x.x.x.x | Atta2 | ~4000 | ~120 | na

## Known Sudoers

James [@james-milburn-crowe](https://github.com/james-milburn-crowe)

## Specific notes for this machine

User home spaces on both machines (`/home/user`) map to a separate physical device on `/mnt/HDD_2`. This is to preserve the faster flash space for OS operations. Large reference datasets (BLAST, Kraken) also map to the same space - you should not need to duplicate BLAST databases, and custom databases you wish to create should probably be stored in the same location.

## CHANGELOG

-- NA --
