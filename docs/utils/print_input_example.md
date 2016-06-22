# Print input example

## Description

This is a script to print the STD input to std output.

When invoked it will simply repeat the input to STDOUT for as long as it's running:

## Author:
Joe Parker, 2016

## License:
As repository

## Usage (invoked mode):

```bash
perl print_input_example.pl 
```	
Will print STDIN to STDOUT, prepended with input line numbers. Exit with ctrl-C.

## Usage (pipe mode):

```bash
<some other shell> | perl print_input_example.pl
```
Will print STDIN to STDOUT, prepended with input line numbers.

