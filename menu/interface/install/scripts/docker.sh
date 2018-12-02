#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################

######################################################## Declare Variables
sname="Docker Install"
pg_docker=$( cat /var/plexguide/pg.docker )
pg_docker_stored=$( cat /var/plexguide/pg.docker.stored )
######################################################## START: PG Log
sudo echo "INFO - Start of Script: $sname" > /var/plexguide/pg.log
sudo bash /opt/plexguide/roles/log/log.sh
######################################################## START: Main Script
if [ "$pg_docker" == "$pg_docker_stored" ]; then
      echo "" 1>/dev/null 2>&1
    else
      echo "Installing / Upgrading Docker" > /var/plexguide/message.phase
      bash /opt/plexguide/menu/interface/install/scripts/message.sh
      ansible-playbook /opt/plexguide/pg.yml --tags docker

      file="/usr/bin/docker" 1>/dev/null 2>&1
        if [ -e "$file" ]
          then
              echo "" 1>/dev/null 2>&1


      #### Checks if Docker Is Present; Fails attempts to Install Old School
      file="/usr/bin/docker" 1>/dev/null 2>&1
        if [ -e "$file" ]
          then
              echo "" 1>/dev/null 2>&1
          else
            ##### Install Docker the Emergency Way
            clear
            echo "Installing Docker the Old School Way - (Please Be Patient)"
            sleep 2
            clear
            curl -fsSL get.docker.com -o get-docker.sh
            sh get-docker.sh
            echo ""
            echo "Starting Docker (Please Be Patient)"
            sleep 2
            systemctl start docker
            sleep 2

            ##### Checking Again, if fails again; warns user
            file="/usr/bin/docker" 1>/dev/null 2>&1
              if [ -e "$file" ]
                then
                echo "INFO - SUCCESS: Docker Failsafe Resulted in a Succesful Docker Install" > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
              else
                echo "INFO - FAILED: Docker Failsafe Resulted in a Failed Docker Install" > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
                  exit
              fi
         fi

      cat /var/plexguide/pg.docker > /var/plexguide/pg.docker.stored
  fi
fi
######################################################## END: Main Script
#
#
######################################################## END: PG Log
sudo echo "INFO - END of Script: $sname" > /var/plexguide/pg.log
sudo bash /opt/plexguide/roles/log/log.sh