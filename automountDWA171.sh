#!/bin/bash

# Sudo check
if [ "$EUID" -ne 0 ]
  then echo "Please run this script with sudo"
  exit
fi

# Add script to switch usb mode
echo 'Adding script to switch USB mode to /usr/bin'

SCRIPT=/usr/bin/dwa171script
cat > $SCRIPT << EOL
#!/bin/bash
usb_modeswitch -KW -v 0bda -p 1a2b
EOL

# Make it executable
echo 'Making it executable'
   
if [ -e $SCRIPT ]; then
   chmod +x $SCRIPT
else
   echo "File $SCRIPT does not exist."   
fi

# Create rule to run script as dongle gets mounted
echo 'Adding udev rule'

cat > /etc/udev/rules.d/dwa171.rules << EOL
ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="1a2b", RUN+="/usr/bin/dwa171script"
EOL

# Reload rules
echo 'Reloading udev rules'

udevadm control --reload-rules

# Done
echo 'Done, try plugging in the dongle'