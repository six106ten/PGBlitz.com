#!/bin/bash
#
# [Ansible Role]
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705
# URL:      https://plexguide.com
#
# PlexGuide Copyright (C) 2018 PlexGuide.com
# Licensed under GNU General Public License v3.0 GPL-3 (in short)
#
#   You may copy, distribute and modify the software as long as you track
#   changes/dates in source files. Any modifications to our software
#   including (via compiler) GPL-licensed code must also be made available
#   under the GPL along with build & install instructions.
#
#################################################################################
### Notes
num=0
echo " " > /var/plexguide/programs.temp
#### Build up list backup list for the main.yml execution
while read p; do
  echo -n $p >> /var/plexguide/programs.temp
  echo -n " " >> /var/plexguide/programs.temp

  num=$[num+1]
  if [ $num == 8 ]; then
    num=0
    echo " " >> /var/plexguide/programs.temp
  fi

done </opt/plexguide/menu/interface/apps/app.list

tee <<-EOF
---------------------------------------------------------------------------
Welcome to the PG Application Suite
---------------------------------------------------------------------------

NOTE: Type in all lowercase!

$p

EOF
################## Selection ########### START
typed=nullstart
prange="$p"
tcheck=""
break=off
while [ "$break" == "off" ]; do

  read -p 'Type the name of a program | PRESS [ENTER]: ' typed
  tcheck=$(echo $prange | grep $typed)
  echo ""

  if [ "$tcheck" == "" ] || [ "$typed" == "0" ]; then
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Failed! Type a Program from the List! "
    echo "--------------------------------------------------------"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    echo ""
    echo ""
  else
    break=on
  fi
done
################## Selection ########### END
if [ "$typed" == "2" ]; then

  typed=nullstart
  prange="$running"
  tcheck=""
  break=off
  while [ "$break" == "off" ]; do
    echo ""
tee <<-EOF
---------------------------------------------------------------------------
SYSTEM MESSAGE: Running Programs for the Top Level Domain (TLD)
---------------------------------------------------------------------------

PROGRAMS:
$running

EOF

    read -p 'Type a Running Program for TLD | PRESS [ENTER]: ' typed
    tcheck=$(echo $prange | grep $typed)
    echo ""

    if [ "$tcheck" == "" ] || [ "$typed" == "0" ]; then
      echo "--------------------------------------------------------"
      echo "SYSTEM MESSAGE: Failed! Type A Running Program "
      echo "--------------------------------------------------------"
      echo ""
      read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      echo ""
      echo ""
    else
tee <<-EOF
---------------------------------------------------------------------------
SYSTEM MESSAGE: TLD Application Set to: $typed
---------------------------------------------------------------------------

EOF
echo "$typed" > /var/plexguide/tld.program
read -n 1 -s -r -p "Press [ANY KEY] to Continue "
echo ""
echo ""
break=on
    fi
  done

elif [ "$typed" == "3" ]; then

  typed=nullstart
  prange="cloudflare digitalocean duckdns gandiv5 godaddy namecheap ovh vultr"
  tcheck=""
  break=off
  while [ "$break" == "off" ]; do
    echo ""
tee <<-EOF
---------------------------------------------------------------------------
SYSTEM MESSAGE: Type to Set the Name of a Provider for Traefik!
---------------------------------------------------------------------------

cloudflare
digitalocean
duckdns
gandiv5
godaddy
namecheap
ovh
vultr

EOF
    read -p 'Type a Provider Name (All LowerCase) | PRESS [ENTER]: ' typed
    tcheck=$(echo $prange | grep $typed)
    echo ""

    if [ "$tcheck" == "" ] || [ "$typed" == "0" ]; then
tee <<-EOF
---------------------------------------------------------------------------
SYSTEM MESSAGE: Failed! Restarting the Process Again!
---------------------------------------------------------------------------

NOTE:
Ensure what you type is all lowercase!

EOF
read -n 1 -s -r -p "Press [ANY KEY] to Continue "
echo ""
echo ""
    else
tee <<-EOF
---------------------------------------------------------------------------
SYSTEM MESSAGE: Success! Provider [$typed] Set!
---------------------------------------------------------------------------

EOF
      read -n 1 -s -r -p "Press [ANY KEY] to Continue " && echo ""
      break=on
      echo "$typed" > /var/plexguide/traefik.provider
    fi
  done

elif [ "$typed" == "4" ]; then

  echo 'INFO - Selected: Traefik & TLD' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh

tee <<-EOF
---------------------------------------------------------------------------
SYSTEM MESSAGE: Traefik Server Domain Interface
---------------------------------------------------------------------------

Current Domain: $pgdomain

EOF
  read -p "Set or Change the Domain (y/n)? " -n 1 -r
  echo    # move cursor to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo ""
    echo "---------------------------------------------------"
    echo "SYSTEM MESSAGE: [Y] Key was NOT Selected - Exiting!"
    echo "---------------------------------------------------"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      echo "";
  else
tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: Set - Change Treafik Server Domain Address!
---------------------------------------------------------------------------

Current Domain: $pgdomain

TYPED EXAMPLES:
plexguide.com
pg123.media
mydomain.net

Note: Domain Must Be All LowerCase!
EOF

break=no
while [ "$break" == "no" ]; do

read -p 'Type a DOMAIN NAME & Then Press [ENTER]: ' typed
tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: DOMAIN NAME - $typed
---------------------------------------------------------------------------

EOF
  read -p "Continue to SET the DOMAIN NAME (y/n)? " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: DOMAIN NAME - [Y] Key was NOT Selected
---------------------------------------------------------------------------

Restarting the Process! Type the Domain Name Again!

EOF
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    echo "";
  else
tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: DOMAIN NAME - $typed
---------------------------------------------------------------------------

DOMAIN NAME is Now Set! Thank You!

EOF
    echo "$typed" > /var/plexguide/server.domain
    break=yes
    read -n 1 -s -r -p "Press [ANY KEY] to Continue ";
  fi
done
      echo "";# leave if statement and continue.
  fi

elif [ "$typed" == "5" ]; then

  echo 'INFO - Selected: Traefik & TLD' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh

tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: Traefik E-Mail Address Domain Interface
---------------------------------------------------------------------------

Current E-Mail Address: $pgemail

EOF
  read -p "Set or Change the E-Mail Address (y/n)? " -n 1 -r
  echo    # move cursor to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo ""
    echo "---------------------------------------------------"
    echo "SYSTEM MESSAGE: [Y] Key was NOT Selected - Exiting!"
    echo "---------------------------------------------------"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      echo "";
  else
tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: Set - Change Treafik Server E-Mail Address!
---------------------------------------------------------------------------

Current Domain: $pgemail

TYPED EXAMPLES:
eatmyshorts@simpsons.com
zombies147@gmail.com
pguber@pgblitz.com

Note: E-Mails Must Be All LowerCase!
EOF

break=no
while [ "$break" == "no" ]; do

read -p 'Type an E-MAIL ADDRESS & Then Press [ENTER]: ' typed
tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: E-MAIL ADDRESS - $typed
---------------------------------------------------------------------------

EOF
  read -p "Continue to SET the E-MAIL ADDRESS (y/n)? " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: E-MAIL ADDRESS - [Y] Key was NOT Selected
---------------------------------------------------------------------------

Restarting the Process! Type the Domain Name Again!

EOF
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    echo "";
  else
tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: E-MAIL ADDRESS - $typed
---------------------------------------------------------------------------

E-Mail Address is Now Set! Thank You!

EOF
    echo "$typed" > /var/plexguide/server.email
    break=yes
    read -n 1 -s -r -p "Press [ANY KEY] to Continue ";
  fi
done
      echo "";# leave if statement and continue.
  fi

  ########################################## DEPLOY START
  elif [ "$typed" == "6" ]; then

fprovider=$(cat /var/plexguide/traefik.provider)
if [ "$fprovider" == "cloudflare" ]; then

tee "INFO" > /tmp/traefik.queslist <<EOF
CLOUDFLARE_EMAIL
 CLOUDFLARE_API_KEY
EOF
  elif [ "$fprovider" == "duckdns" ]; then
tee "INFO" > /tmp/traefik.queslist <<EOF
DUCKDNS_TOKEN
EOF
  elif [ "$fprovider" == "gandiv5" ]; then
tee "INFO" > /tmp/traefik.queslist <<EOF
GANDIV5_API_KEY
EOF
elif [ "$fprovider" == "vultr" ]; then
tee "INFO" > /tmp/traefik.queslist <<EOF
VULTR_API_KEY
EOF
  elif [ "$fprovider" == "godaddy" ]; then
tee "INFO" > /tmp/traefik.queslist <<EOF
GODADDY_API_KEY
 GODADDY_API_SECRET
EOF
elif [ "$fprovider" == "digitalocean" ]; then
tee "INFO" > /tmp/traefik.queslist <<EOF
DO_AUTH_TOKEN
EOF
  elif [ "$fprovider" == "namecheap" ]; then
tee "INFO" > /tmp/traefik.queslist <<EOF
NAMECHEAP_API_USER
 NAMECHEAP_API_KEY
EOF
  elif [ "$fprovider" == "ovh" ]; then
tee "INFO" > /tmp/traefik.queslist <<EOF
OVH_ENDPOINT
 OVH_APPLICATION_KEY
 OVH_APPLICATION_SECRET
 OVH_CONSUMER_KEY
EOF
  else
  echo "WARNING! This FAILED!"
fi

####################### WHILE FOR ADDITONAL QUESTIONS # START
tee <<-EOF
---------------------------------------------------------------------------
SYSTEM MESSAGE: Additional Traefik Information
---------------------------------------------------------------------------

NOTE 1: You will be asked a series of questions based on your domain
provider! Failing to respond correctly will result in not being issued
an SSL certificate.

NOTE 2: PlexGuide will store your information incase of future
redeployments!

EOF
read -n 1 -s -r -p "Press [ANY KEY] to Continue " < /dev/tty

while read p; do

### check to make sure var exist
  file="/var/plexguide/$p"
  if [ ! -e "$file" ]; then
    echo NOT-SET > /var/plexguide/$p
    display="NOT-SET"
  else
    display=$(cat /var/plexguide/$p)
  fi

tee <<-EOF


---------------------------------------------------------------------------
SYSTEM MESSAGE: $p - $display
---------------------------------------------------------------------------

EOF

read -r -p "Change '$p' (y/n)? " -n 1 -r < /dev/tty
echo    # move cursor to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  null=null
else
tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: SET INFO for $p
---------------------------------------------------------------------------

EOF

break=no
while [ "$break" == "no" ]; do

read -p 'Update Info - Then Press [ENTER]: ' typed < /dev/tty

tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: $p - $typed
---------------------------------------------------------------------------
EOF
  echo "$typed" > /var/plexguide/$p
  break=yes
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue " < /dev/tty
done
    echo "";# leave if statement and continue.
fi
####################### WHILE FOR ADDITONAL QUESTIONS END

done </tmp/traefik.queslist
echo "NOTE: Deploying Traefik Next!"
echo ""
read -n 1 -s -r -p "Press [ANY KEY] to Continue " < /dev/tty
### Execute Traefik
ansible-playbook /opt/plexguide/menu/interface/traefik/common.yml
ansible-playbook /opt/plexguide/menu/interface/traefik/$provider.yml

tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: We Must Rebuild Your Containers!
---------------------------------------------------------------------------

EOF
    read -n 1 -s -r -p "Press [ANY KEY] to Continue" < /dev/tty

bash /opt/plexguide/menu/interface/traefik/rebuild2.sh

tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: Treafik Deployment Complete!
---------------------------------------------------------------------------

EOF
    read -n 1 -s -r -p "Press [ANY KEY] to Continue" < /dev/tty

else
  typed="1"
  echo ""
  echo 'INFO - Exiting PlexGuide & Display Ending Menu' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
  bash /opt/plexguide/roles/ending/ending.sh
  exit
fi

################## End State ########### STARTED
done
