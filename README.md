# emPC-A/RPI4 by Janz Tec AG

This script installs and configures device drivers for emPC-A/RPI4.

## Installation instructions

### Preconditions
 * Raspberry Pi OS 32-bit
 * Linux Kernel Version 6.1 or later
 * At least 1GB free disk space
 * Internet connection

### Installation
```
sudo bash
cd /tmp
wget https://raw.githubusercontent.com/janztec/empc-arpi4-linux-drivers/main/install.sh -O install.sh
bash install.sh
```

#### Unattended mode
If you add the -y command line switch , you can activate the unattended mode.
This will run the installation automatically without a need for human interaction.
You can also add the -k command line switch to ignore the kernel version check, so you can use the installation script in e.g. build environments.
Please use this command line switch only if you are sure that all changes should be carried out by the installation script.
