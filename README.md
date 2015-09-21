# gpu-driver-swap

gpu-driver-swap is a systemd service to automatically swap AMD / Nvidia / Intel drivers on boot. It allows proprietary AMD and Nvidia drivers to be installed side-by-side, and automatically sets up the correct drivers at boot depending on which card is plugged in. Intel drivers are also supported.

## NOTE

>Installing proprietary drivers will overwrite the Intel drivers. If you intend to swap between AMD/Nvidia and Intel, then you should backup your Intel drivers beforehand. See [Additional steps for Intel graphics](#aditional-steps-for-intel-graphics)

## Requirements

* systemd-based distribution (see [Installing on SysV distributions](#installing-on-sysv-distributions))
* Official vendor drivers for installed graphics hardware (nvidia, fglrx, intel)

## Installation

    # make install
    # systemctl enable gpu-driver-swap.service

### Aditional steps for Intel graphics

If you wish to use with Intel graphics, then you must back up the following files before installing any proprietary drivers:

    # cp /usr/lib64/xorg/modules/extensions/libglx.so /usr/lib64/xorg/modules/extensions/libglx.so.intel
    # cp /usr/lib64/libGL.so /usr/lib64/libGL.so.intel
    # cp /etc/X11/xorg.conf /etc/X11/xorg.conf.intel

## Configuration

*gpu-driver-swap* requires no configuration provided you place your AMD, Nvidia and Intel Xorg configs at */etc/Xorg/xorg.conf.<nvidia/amd/intel>*. *gpuswap.sh* contains several configuration variables for AMD, Nvidia and Intel cards:

* `libglx_path` - GLX shared library to use (usually *libglx.so.xxx.xx* for Nvidia and *fglrx-libglx.so* for AMD)
* `libgl_path` - OpenGL shared library to use (usually *libGL.so.xxx.xx* for Nvidia and *fglrx.libGL.so.x.x* for AMD)
* `xorg_path` - Xorg config file to use - try and put as much shared stuff in */etc/xorg/xorg.conf.d* as possible, and only put `Device` sections in *xorg.conf*

## Installing on SysV distributions

TODO
