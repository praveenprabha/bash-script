# bash-script


## Table of Contents (Optional)

- [Purpose](#purpose)
- ["getopts" template scripts](#scripts-with-parameter-using-getopts)
- [ nagios scripts](#nagios-script)



## Purpose

This serves as a repository for all my shell scripts. Still in the process of uploading more scripts.

## Scripts with Parameter using "getopts"

Template Script Available :  <a href="https://github.com/praveenprabha/bash-script/blob/master/getopts_script_template.sh" target="_blank">`getopts_script_template.sh`</a>.

  - Incorporates option for script help which shows how to use the script
  - Includes Optional and Mandatory Arguments
  - Feature to ensure that second flag is not accepted as argument for first flag


## Nagios Script

Bash Script for following functionality is available. All scripts makes use of SSH to login to remote server and gather the information. Here, the scripts are wriiten with the consideration that there is a passwordless login available from Nagios Server to Target Server. 

Following considerations are taken into account for these scripts
  - Passwordless (keybased) authentication is already enabled from Nagios Server to Servers being monitored.
  - These programs are written for ubuntu machine hence the "ubuntu" user is included in script as a variable. If there is a different user, feel free to modify it.

Scripts Avaialble under this section.
  - CPU Check
  - Disk Space Check
  - Memory Check
  - Process Check