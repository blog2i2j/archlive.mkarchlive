#!/bin/bash

# This shell script is run before Openbox launches.
# Environment variables set here are passed to the Openbox session.

# D-bus
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi

USE_IBUS=1   #use ibus input 
USE_SCIM=0   #use scim input
USE_FCITX=0   #use fcitx input

#=======================================
if [ ${USE_SCIM} -eq 1 ] ;then
    export XIM=scim
    export XMODIFIERS="@im=scim"
    export XIM_PROGRAM="/usr/bin/scim"
    export GTK_IM_MODULE="scim-bridge"
    export QT_IM_MODULE="scim-bridge"
    export XIM_ARGS="-d"

    if [ -z `pidof scim` ] ; then
        scim-birdge  &
    fi
fi

#=======================================

if [ ${USE_FCITX} -eq 1 ] ;then
    export XIM=fcitx
    export XMODIFIERS="@im=fcitx"
    export XIM_PROGRAM="/usr/bin/fcitx"
    export GTK_IM_MODULE="fcitx"
    export QT_IM_MODULE="fcitx"
    export XIM_ARGS="-d"

    if [ -z `pidof fcitx` ] ; then
        fcitx &
    fi
fi

#=======================================
if [ ${USE_IBUS} -eq 1 ] ;then
    export XMODIFIERS="@im=ibus"
    export GTK_IM_MODULE="ibus"
    export QT_IM_MODULE="ibus"
    export XIM=ibus
    export XIM_PROGRAM=/usr/bin/ibus-daemon
    export XIM_ARGS="-d -x"
    pkill -9 ibus-daemon
    ibus-daemon -d -x 
    #ibus&
fi
#=======================================

pcmanfm -d &
# Make GTK apps look and behave how they were set up in the gnome config tools
[ -f /usr/libexec/gnome-settings-daemon ] && eval `/usr/libexec/gnome-settings-daemon & >/dev/null 2>&1` 

# Preload stuff for KDE apps
#if which start_kdeinit >/dev/null; then
#  LD_BIND_NOW=true start_kdeinit --new-startup +kcminit_startup &
#fi

#Force OpenOffice.org to use GTK theme
export OOO_FORCE_DESKTOP=gnome

# Xmodmap
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# Xresources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

feh --bg-scale ~/.config/wallpapers/Tiger_Blue.jpg

#killall xcompmgr >/dev/null
#xcompmgr -Ss -n -Cc -fF -I-10 -O-10 -D1 -t-3 -l-4 -r4 &

# set panel
#killall tint2 > /dev/null 2>&1
#tint2 & > /dev/null

# set lxpanel
killall lxpanel > /dev/null 2>&1
lxpanel & > /dev/null

# wbar
#killall wbar >/dev/null
#wbar &

# Conky
#killall conky > /dev/null 2>&1
#conky -c /etc/xdg/conkyrc.openbox & > /dev/null

# vattery
#killall vattery > /dev/null 2>&1
#vattery & >/dev/null

# Networkmanager-applet
nm-applet --sm-disable & >/dev/null 2>&1

# wicd
#killall wicd-client > /dev/null 2>&1
#wicd-client & > /dev/null 2>&1

# fcitx
killall fcitx > /dev/null 2>&1
fcitx & > /dev/null 2>&1


