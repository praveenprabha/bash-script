#! /bin/bash

#####################################################
# Title Name            : CPU Check Bash Script
# Description           : Script to Check Memory Usage on remote machine
# Author                : Praveen Prabhakaran
# Date                  : 23-Sep-2020
# Version               : 1.0.0
# Additional Notes      : 
#####################################################



##### Color and Font Customization #####

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NoColor='\033[0m'

set_blink='\033[5m'
reset_blink='\033[25m'



########## Function Defining Usage ##########
usage() {
echo -e "

  SCRIPT:
      ${0#./*} - Check CPU usage on a remote server

  Synopsis:
      $0 [ OPTIONS ]

  Mandatory OPTIONS :
      - t <Target Server>     # Specify Target Server IP address (IPv4)
      - w <Warning Limit>     # To set Warning Limit for the script
      - c <Critical Limit>    # To set Critical Limit for the script
  
  Non-Mandatory OPTIONS:
      - h                     # Help to use the script
  
  USAGE  ${BLUE}$0${NoColor} ${YELLOW}[ - t <Target Server> ] [ - w <Warning Limit> ] [ - c <Critical Limit> ]${NoColor}


"
}


########## Function to validate target IP address for IPv4 Address ##########
valid_ip() {
  
    local ip=$*
    local valid=yes

    ### IPv4 address pattern matching ###
    echo $ip | grep -qE '^([0-9]{1,3}[.]){3}[0-9]{1,3}$' 
    if [ $? -ne 0 ]
    then
        valid="Not a valid IPv4 address - Incorrect Format"
        exit 10
    else 
      local IFS=.
      ip=($ip)
      for octact in ${ip[@]}
      do
          if [ ${octact} -le 0 ] || [ ${octact} -gt 255 ]
          then
            valid="Not a valid IPv4 address - Out of Range"
            break
          fi
      done
     fi 
    echo $valid

}




########## Using getopts to define OPTIONS to be used in the script ##########


required_options=0            # to get a control on number of required options in script.

while getopts ':t:w:c:h' param
do
    case $param in
        t)    if [ ${OPTARG:0:1} == "-"  ]
              then
                  echo -e "${RED}ERROR: \"${1}\" requires an argument.${NoColor}"
                  shift
                  error_status=1
              else
                  target_server=${OPTARG}
                  check_valid=$(valid_ip $target_server)
                  if [ "${check_valid}" != 'yes' ]
                  then
                    echo ${check_valid}
                    error_status=1
                  fi
                  shift 2
              fi
              OPTIND=1
              required_options=$(( required_options + 1 ))
              # echo ${OPTIND}
              # echo $@
              ;;
        w)    if [ ${OPTARG:0:1} == "-"  ]
              then
                  echo -e "${RED}ERROR: \"$1\" requires an argument.${NoColor}"
                  shift
                  error_status=1
              else
                  warning_limit=${OPTARG}
                  shift 2
              fi
              OPTIND=1
              required_options=$(( required_options + 1 ))
              # echo ${@}
              ;;
        c)    if [ ${OPTARG:0:1} == "-"  ]
              then
                  echo -e "${RED}ERROR: \"${1}\" requires an argument.${NoColor}"
                  shift
                  error_status=1
              else
                  critical_limit=${OPTARG}
                  shift 2
              fi
              OPTIND=1
              required_options=$(( required_options + 1 ))
              ;;
        h)    usage
              exit 10
              ;;
        \?)   echo -e "${RED}ERROR: Invalid Option \"-$OPTARG\" entered${NoColor}"
              error_status=1
              ;;
        :)    echo -e "${RED}ERROR: \"-${OPTARG}\" requires an argument.${NoColor}"
              error_status=1
              ;;
    esac

done

##### For anything that had error, should display the usage and then exit #####
[[ $error_status ]] && usage && exit 10

##### For execution not matching all Mandatory OPTIONS  #####
[[ $required_options != 3 ]] && echo -e "${RED}ERROR: One or more REQUIRED options missing${NoColor}" && usage && exit 10


##### Checking the gathered values #####
echo "Target Machine  : ${target_server}"
echo "Warning Limit   : ${warning_limit}"
echo "Critical Limit  : ${critical_limit}"


