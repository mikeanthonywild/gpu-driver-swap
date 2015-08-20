#!/bin/bash

# Script to swap AMD/Nvidia drivers on boot. Both drivers must have
# been installed first, as the script relies on the various libraries
# being in their default locations. Script works by overriding
# symlinks on libglx.so, libgl.so and xorg.conf. Once these point to
# the AMD/Nvidia libraries, hardware-accelerated OpenGL is available.

function use_nvidia {
    # UPDATE THESE PATHS
    driver_pkg=nvidia
    libglx_path=$(find /usr/lib64/xorg/modules/extensions/ -name 'libglx.so.*' | sort -r | head -n 1)
    libgl_path=$(find /usr/lib64/ -name 'libGL.so.*' | sort -r | head -n 1)
    xorg_path=/etc/Xorg/xorg.conf.nvidia
}


function use_fglrx {
    # UPDATE THESE PATHS
    driver_pkg=fglrx
    libglx_path=/usr/lib64/xorg/modules/extensions/fglrx/fglrx-libglx.so
    libgl_path=/usr/lib64/fglrx/fglrx-libGL.so.1.2  
    xorg_path=/etc/Xorg/xorg.conf.amd
}


function swap_drivers {
    echo "Using $driver_pkg driver"
    
    # libglx
    printf "Linking libglx.so..."
    if [ -s $libglx_path ]; then
        ln -snf $libglx_path /usr/lib64/xorg/modules/extensions/libglx.so
        # Needed for dynamic switching
        # ldconfig /usr/lib64/xorg/modules/extensions
        echo OK
    else
        echo ERROR
        echo "Couldn't find $libglx_path"
        exit 1
    fi

    # libGL
    printf "Linking libGL.so.1..."
    if [ -s $libgl_path ]; then
        ln -snf $libgl_path /usr/lib64/libGL.so.1
        # Needed for dynamic switching
        # ldconfig /usr/lib64
        echo OK
    else
        echo ERROR
        echo "Couldn't find $libgl_path"
        exit 1
    fi

    # Xorg
    printf "Linking xorg.conf..."
    if [ -s $xorg_path ]; then
        ln -snf $xorg_path /etc/X11/xorg.conf
        echo OK
    else
        echo ERROR
        echo "Couldn't find $xorg_path"
        exit 1
    fi
}


# Main entry point
kmsg=$(lspci | grep VGA)
echo $kmsg

if [[ $kmsg == *"NVIDIA"* ]]; then
    use_nvidia
elif [[ $kmsg == *"AMD"* ]]; then
    use_fglrx
else
    echo "ERROR: Unsupported VGA controller"
    exit 1
fi

swap_drivers
exit 0
