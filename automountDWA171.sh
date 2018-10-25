#!/bin/bash

# Sudo check
if [ "$EUID" -ne 0 ]
  then echo "Please run as elevated user"
  exit
fi

# Add script to switch usb mode
echo 'Adding script to switch USB mode to /usr/bin'
touch /usr/bin/dwa171script
echo '#!/bin/bash' > /usr/bin/dwa171script
echo 'usb_modeswitch -KW -v 0bda -p 1a2b' >> /usr/bin/dwa171script

# Make it executable
echo 'Making it executable'
chmod +x /usr/bin/dwa171script

# Create rule to run script as dongle gets mounted
echo 'Adding udev rule'
echo 'ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="1a2b", RUN+="/usr/bin/dwa171script"' | tee /etc/udev/rules.d/dwa171.rules

# Reload rules
echo 'Reloading udev rules'
udevadm control --reload-rules

# Done
echo 'Done'