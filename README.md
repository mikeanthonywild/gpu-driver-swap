# gpu-driver-swap

gpu-driver-swap is a systemd service to automatically swap AMD / Nvidia drivers on boot. It allows proprietary AMD and Nvidia drivers to be installed side-by-side, and automatically sets up the correct drivers at boot depending on which card is plugged in.

## Requirements

* systemd-based distribution (see [Installing on SysV distributions](#Installingonsysvdistributions)
* Proprietary AMD and Nvidia drivers

## Installation

    # make install
    # systemctl enable gpu-driver-swap.service

## Installing on SysV distributions

TODO
