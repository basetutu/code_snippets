

# install new bluego
stop bluego && copy over && start bluego



./make.sh bluetooth-manager



scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ # for installing app
scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json



#Use on target device
mount -o remount,rw / && systemctl stop system-server && cp -r usr/* /usr/ && systemctl start system-server # for installing extension and html-runtime
mount -o remount,rw / && systemctl stop system-server && cp -r usr/* /usr/lib/ && systemctl start system-server # for installing extension
mount -o remount,rw / && systemctl stop bluetooth-manager && cp BluetoothServer /usr/bin && systemctl start bluetooth-manager # for installing manager








/////////////////////////

systemctl restart location-manager
systemctl restart wifi-manager
systemctl restart bsb

///////////////////////






# BSB
/home/saeed/_ALL_MY_STUFF/bosch_may/out/SDK/tools/
./bsb install <path to bpk>

# Updating an application on target without the need to flash
# use on host PC
bitbake services-api -c cleanall
bitbake services-api
bitbake -b bluetooth-manager-extension
bitbake -b html-runtime_1.0.0 -c clean
bitbake -b html-runtime_1.0.0


bitbake -b location-manager-extension
bitbake -b html-runtime_1.0.0 -c clean
bitbake bluetooth-manager-extension
bitbake -b bluetooth-manager-extension
bitbake html-runtime_1.0.0
bitbake -b bluetooth-manager_1.0.0



bitbake bluetooth-manager-extension
bitbake bluetooth-manager
bitbake html-runtime_1.0.0



bitbake bluetooth-manager-extension # extension
bitbake bluetooth-manager # manager






# ... installed!

# Start before going home
./make.sh reset && . proxyoff && ./make.sh && . proxyon && ./make.sh && . proxyoff && ./make.sh && . proxyon && ./make.sh && . proxyoff && ./make.sh && . proxyon && ./make.sh && . proxyoff && ./make.sh

# Start DLT-viewer
sudo LD_LIBRARY_PATH=. ./dlt_viewer


# Start SlickEdit
cd /opt/slickedit-pro2016/bin/ && sudo ./vs


echo '#!/bin/bash
alias cls="printf '\033c'"
alias l="ls -CF"
alias la="ls -A"
alias ll="ls -alF"
alias ls="ls --color=auto"
alias rm_debug="rm /usr/bin/cef3/debug.log && echo debug.log removed"
alias restart="systemctl restart system-server && systemctl restart bsb && echo system-server and bsb restarted."
alias app_inst_check="grep com.bosch.connectivity /data/system/db/applications.json"
alias uninstall="rm /data/system/install-cache/connectivity-test-app.bpk"
alias cef_JS_Script_Output="cat /usr/bin/cef3/debug.log | grep connectivity"
alias see_all_apps="grep "id" /data/system/db/applications.json"
alias portforward="ssh -L 0.0.0.0:9223:localhost:9222 localhost"' > .bashrc


==============================================================================================
# How to run the ASF client tester to check API functionality of manager

bitbake bluetooth-manager-asf-test

scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/

scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/


#Log in på device i två olika fönster med 
ssh root@192.168.1.100

1:
$ systemctl stop bluetooth-manager
$ ./BluetoothServer

2: 
$ ./BluetoothManagerClient

==============================================================================================



alias asd='export BOSCH_REPO_DIR=`pwd` && cpoot() { cd $BOSCH_REPO_DIR/$1 }'
