# Bash Scripts from Praveen P


## Table of Contents (Optional)
---

- [Purpose](#purpose)
- ["getopts" template scripts](#scripts-with-parameter-using-getopts)
- [ nagios scripts](#nagios-script)



## Purpose
---

This serves as a repository for all my shell scripts. Still in the process of uploading more scripts.



## Scripts with Parameter using "getopts"

Template Script Available :  <a href="getopts_script_template.sh" target="_blank">`getopts_script_template.sh`</a>.

  - Incorporates option for script help which shows how to use the script
  - Includes Optional and Mandatory Arguments
  - Feature to ensure that second flag is not accepted as argument for first flag






##### using "-h" to get usage information
````shell
root@nagios-server:/etc/nagios3/conf.d/my_scripts/nagios_script# ./cpu_usage_param.sh -h


  SCRIPT:
      cpu_usage_param.sh
            This script helps to checks CPU usage on a remote machine and generate
            following exit code for OKAY, WARNING and CRITICAL limits set.

            -----------------------------
            |  Exit Code  |    Status   |
            -----------------------------
            |      0      |  OK         |
            |      1      |  WARNING    |
            |      2      |  CRITICAL   |
            -----------------------------

  SYNOPSIS:
      ./cpu_usage_param.sh [ OPTIONS ]

  Mandatory OPTIONS :
      - t <Target Server>     # Specify Target Server IP address (IPv4)
      - w <Warning Limit>     # To set Warning Limit for the script
      - c <Critical Limit>    # To set Critical Limit for the script

  Non-Mandatory OPTIONS:
      - h                     # Help to use the script

  USAGE  ./cpu_usage_param.sh [ - t <Target Server> ] [ - w <Warning Limit> ] [ - c <Critical Limit> ]



root@nagios-server:/etc/nagios3/conf.d/my_scripts/nagios_script#

````





##### error when a mandatory argument is missing

```shell

root@nagios-server:/etc/nagios3/conf.d/my_scripts/nagios_script# ./cpu_usage_param.sh -t
ERROR: "-t" requires an argument.


  SCRIPT:
      cpu_usage_param.sh
            This script helps to checks CPU usage on a remote machine and generate
            following exit code for OKAY, WARNING and CRITICAL limits set.

            -----------------------------
            |  Exit Code  |    Status   |
            -----------------------------
            |      0      |  OK         |
            |      1      |  WARNING    |
            |      2      |  CRITICAL   |
            -----------------------------

  SYNOPSIS:
      ./cpu_usage_param.sh [ OPTIONS ]

  Mandatory OPTIONS :
      - t <Target Server>     # Specify Target Server IP address (IPv4)
      - w <Warning Limit>     # To set Warning Limit for the script
      - c <Critical Limit>    # To set Critical Limit for the script

  Non-Mandatory OPTIONS:
      - h                     # Help to use the script

  USAGE  ./cpu_usage_param.sh [ - t <Target Server> ] [ - w <Warning Limit> ] [ - c <Critical Limit> ]



root@nagios-server:/etc/nagios3/conf.d/my_scripts/nagios_script# 
```





##### error when only attributes are mentioned and not arguments
_NOTE: second attribute is not considered as the argument for the first attribute_
```Shell
root@nagios-server:/etc/nagios3/conf.d/my_scripts/nagios_script# ./cpu_usage_param.sh -t -w -c
ERROR: "-t" requires an argument.
ERROR: "-w" requires an argument.
ERROR: "-c" requires an argument.


  SCRIPT:
      cpu_usage_param.sh
            This script helps to checks CPU usage on a remote machine and generate
            following exit code for OKAY, WARNING and CRITICAL limits set.

            -----------------------------
            |  Exit Code  |    Status   |
            -----------------------------
            |      0      |  OK         |
            |      1      |  WARNING    |
            |      2      |  CRITICAL   |
            -----------------------------

  SYNOPSIS:
      ./cpu_usage_param.sh [ OPTIONS ]

  Mandatory OPTIONS :
      - t <Target Server>     # Specify Target Server IP address (IPv4)
      - w <Warning Limit>     # To set Warning Limit for the script
      - c <Critical Limit>    # To set Critical Limit for the script

  Non-Mandatory OPTIONS:
      - h                     # Help to use the script

  USAGE  ./cpu_usage_param.sh [ - t <Target Server> ] [ - w <Warning Limit> ] [ - c <Critical Limit> ]



root@nagios-server:/etc/nagios3/conf.d/my_scripts/nagios_script#

```





##### successful execution

```shell

root@nagios-server:/etc/nagios3/conf.d/my_scripts/nagios_script# ./cpu_usage_param.sh -t 172.31.47.66  -w 0.5 -c 1
CPU OK. Current CPU Usage: 0.00
root@nagios-server:/etc/nagios3/conf.d/my_scripts/nagios_script#

```











## Nagios Script
---
Bash Script for following functionality is available. All scripts makes use of SSH to login to remote server and gather the information. Here, the scripts are wriiten with the consideration that there is a passwordless login available from Nagios Server to Target Server. 

Following considerations are taken into account for these scripts
  - Passwordless (keybased) authentication is already enabled from Nagios Server to Servers being monitored.
  - These programs are written for ubuntu machine hence the "ubuntu" user is included in script as a variable. If there is a different user, feel free to modify it.

Scripts Avaialble under this section.
  - <a href="nagios_script/cpu_usage_param.sh" target="_blank">`CPU Check`</a>
  - <a href="nagios_script/disk_usage_param.sh" target="_blank">`Disk Space Check`</a>
  - <a href="nagios_script/memory_usage_param.sh" target="_blank">`Memory Check`</a>
  - <a href="nagios_script/process_check_param.sh" target="_blank">`Process Check`</a>