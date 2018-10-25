#!/bin/bash

# Add script to switch usb mode
touch /usr/bin/dwa171script
echo '#!/bin/bash' > /usr/bin/dwa171script
echo 'usb_modeswitch -KW -v 0bda -p 1a2b' > /usr/bin/dwa171script

# Make it executable
chmod +x /usr/bin/dwa171script

# Create rule to run script as dongle gets mounted
echo 'ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="1a2b", RUN+="/usr/bin/dwa171script"' | tee /etc/udev/rules.d/dwa171.rules

# Reload rules
udevadm control --reload-rules
