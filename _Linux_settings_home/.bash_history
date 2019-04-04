alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
cls
rsync
cd appfw/js-api/
gstatus 
git difftool 
gstatus 
up
cd tools/native/
git status 
git difftool 
cd ..
cls
. setup_env.sh 
cls
#use on host PC:
alias up='cd ..'
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore pacd _ALL_MY_STUFF/bosch_may
. setup_env.sh 
#use on host PC:
alias up='cd ..'
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
cls
cd out/bui35x/
bitbake -b bluetooth-manager_1.0.0
flash_me 
alias rebootbui='ssh root@192.168.1.100 reboot'
ssh root@192.168.1.100 htop
rebootbui 
ssh-keygen -f "/home/saeed/.ssh/known_hosts" -R 192.168.1.100
rebootbui 
cd ..
cd services/bluetooth-manager/
grep "TODO" -r .
grep "onDeviceLost" -r .
grep "TODO" -r .
grep "remove this" -r .
sudo ./eclipse 
bg
sudo ./eclipse 
bg
sudo gnome-system-monitor 
bg
#use on host PC:
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
start_dlt
cd _ALL_MY_STUFF/bosch_may
start_dlt
bg
sudo openFolder 
alias openFolder='sudo xdg-open .'
openFolder 
openFolder 
cd ~
openFolder 
alias openFolder='sudo xdg-open .'
openFolder 
ll
sudo mousepad .bashrc 
git fetch ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/os/prebuilt/eso refs/changes/08/5108/1 && git cherry-pick FETCH_HEAD
git log
cd _ALL_MY_STUFF/bosch_may
. setup_env.sh 
cd out/bui35x/
bitbake -b bluetooth-manager_1.0.0
bitbake bluetooth-manager
bitbake -b bluetooth-manager_1.0.0
bitbake bluetooth-manager
ssh root@192.168.1.100 htop
ssh root@192.168.1.100
ssh root@192.168.1.100 htop
ssh root@192.168.1.100
bitbake -b bluetooth-manager_1.0.0
bitbake -c cleanall bluetooth-manager
bitbake -c cleanall services-api
bitbake -c cleanall bluetooth-manager-extension
bitbake bluetooth-manager
cd tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/
ll
ssh root@192.168.1.100
up
cd bluetooth-manager-extension/1.0.0-r0/packages-split/bluetooth-manager-extension/
ll
up
bitbake bluetooth-manager-extension
cd tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/packages-split/bluetooth-manager-extension/
ll
up
find . -iname bluetooth*
find . -iname "bluetooth*"
find . -iname "bluetooth-manager*" | grep extension
find . -iname "bluetooth-manager*" | grep extension -ls
find . -iname "bluetooth-manager*" -ls | grep extension
ll
cd bluetooth-manager-extension/1.0.0-r0/package/usr/lib/
ll
cd ..
up
cd html-runtime/1.0.0-r0/packages-split/html-runtime
ll
cd usr/bin/cef3/
ll
openFolder 
ipconfig
ifconfig
ssh root@192.168.1.100
scp root@192.168.1.100/home/root/bluego_log.txt .
scp ssh root@192.168.1.100/home/root/bluego_log.txt .
scp root@192.168.1.100:/home/root/bluego_log.txt .
ssh root@192.168.1.100
scp root@192.168.1.100:/home/root/bluego_log.txt ./bluego_log-2.txt
ll
ssh root@192.168.1.100
cd _ALL_MY_STUFF/bosch_may
. setup_env.sh 
cd out/bui35x/
bitbake -b libdbushelper
bitbake libdbushelper
scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/
ssh root@192.168.1.100
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
bsb_install_manager_test
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
bsb_install_manager_test
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
bsb_install_manager_test
ssh root@192.168.1.100
alias rebootbui='ssh root@192.168.1.100 reboot'
ssh root@192.168.1.100
croot
up
ssh root@192.168.1.100
up
bitbake
up
. setup_env.sh 
cd out/bui35x/
bitbake bluetooth-manager_1.0.0
bitbake -b bluetooth-manager_1.0.0
bitbake bluetooth-manager
bitbake -b bluetooth-manager_1.0.0
bitbake bluetooth-manager
bitbake bluetooth-manager-asf-test
bitbake -b bluetooth-manager_1.0.0
bitbake bluetooth-manager-asf-test
bitbake -b bluetooth-manager-asf-test
bitbake -b bluetooth-manager-asf-test | grep 407
bitbake -b bluetooth-manager-asf-test
bitbake -b bluetooth-manager_1.0.0
bitbake bluetooth-manager
bitbake bluetooth-manager | grep .cpp:
bitbake bluetooth-manager
bitbake bluetooth-manager-asf-test
scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/
scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/
ssh root@192.168.1.100
scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/
ssh root@192.168.1.100
bitbake -b bluetooth-manager
bitbake -b bluetooth-manager_
scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/
ssh root@192.168.1.100
bitbake -b bluetooth-manager_
bitbake bluetooth-manager
scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/
ssh root@192.168.1.100
bitbake bluetooth-manager
ssh root@192.168.1.100
scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/
ssh root@192.168.1.100
stop_bluetooth_manager
ssh root@192.168.1.100
bitbake bluetooth-manager
bitbake -b bluetooth-manager_
scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/
ssh root@192.168.1.100
bitbake bluetooth-manager-asf-test
scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/
ssh root@192.168.1.100
bitbake bluetooth-manager-asf-test
scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/
ssh root@192.168.1.100
bitbake bluetooth-manager-asf-test
bitbake -b bluetooth-manager-asf-test
scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/
ssh root@192.168.1.100
bitbake bluetooth-manager
scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/
ssh root@192.168.1.100
scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/
bitbake bluetooth-manager
bitbake -b bluetooth-manager-asf-test
scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/
ssh root@192.168.1.100
bitbake -b bluetooth-manager-asf-test
scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/
ssh root@192.168.1.100
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
bsb_install_asf_client_test
bitbake -b bluetooth-manager-asf-testalias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
bsb_install_asf_client_test
ssh root@192.168.1.100
bitbake bluetooth-manager
sudo ./eclipse 
bg
openFolder 
openFolder 
bg
exit
sudo ./eclipse 
bg
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
start_dlt 
cd _ALL_MY_STUFF/bosch_may
start_dlt 
sudo ./dbus_bluego_btsnoop_on 
. setup_env.sh 
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cls='printf "\033c"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias openFolder='sudo xdg-open .'
alias up='cd ..'
#use on host PC:
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
cls
. setup_env.sh 
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cls='printf "\033c"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias openFolder='sudo xdg-open .'
alias up='cd ..'
#use on host PC:
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
cls
./make.sh 
cd tools/mfg/
./flash.sh 
cd ..
up
bsb_install_2
ssh-keygen -f "/home/saeed/.ssh/known_hosts" -R 192.168.1.100
bsb_install_2
bsb_install_manager
. setup_env.sh 
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cls='printf "\033c"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias openFolder='sudo xdg-open .'
alias up='cd ..'
#use on host PC:
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
cls
cd services/bluetooth-manager/
opyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
cls
cd ..
up
#use on host PC:
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cls='printf "\033c"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias openFolder='sudo xdg-open .'
alias up='cd ..'
#use on host PC:
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
cls
cd out/bui35x/
bitbake bluetooth-manager
cd ..
. setup_env.sh 
cd _ALL_MY_STUFF/bosch_may
. setup_env.sh 
cd out/bui35x/
bitbake -b bluetooth-manager_
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cls='printf "\033c"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias openFolder='sudo xdg-open .'
alias up='cd ..'
#use on host PC:
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
cls
bitbake bluetooth-manager
sudo ./eclipse 
bg
. setup_env.sh 
cls
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cls='printf "\033c"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias openFolder='sudo xdg-open .'
alias up='cd ..'
#use on host PC:
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
#alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
alias bsb_install_bluego='stop_bluetooth_manager && ssh root@192.168.1.100 systemctl stop bluego && remount_drive && scp dbus_bluego root@192.168.1.100:/usr/bin && ssh root@192.168.1.100 systemctl start bluego && start_bluetooth_manager'
alias connect_to_bui='ssh root@192.168.1.100'
cls
bsb_install_asf_client_test
git diff
. setup_env.sh 
rsync
./make.sh 
openFolder 
cd _ALL_MY_STUFF/bosch_may
. setup_env.sh 
cls
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cls='printf "\033c"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias openFolder='sudo xdg-open .'
alias up='cd ..'
#use on host PC:
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
#alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
./make.sh bluetooth-manager
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cls='printf "\033c"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias openFolder='sudo xdg-open .'
alias up='cd ..'
#use on host PC:
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
#alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
alias bsb_install_bluego='stop_bluetooth_manager && ssh root@192.168.1.100 systemctl stop bluego && remount_drive && scp dbus_bluego root@192.168.1.100:/usr/bin && ssh root@192.168.1.100 systemctl start bluego && start_bluetooth_manager'
alias connect_to_bui='ssh root@192.168.1.100'
cls
connect_to_bui 
bsb_install_manager_test
alias connect_to_bui='ssh root@192.168.1.100'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && echo ------- && copy_manager_for_testing && echo ------- && stop_bluetooth_manager && echo ------- && connect_to_bui && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
bsb_install_manager_test
alias bsb_install_manager_test='echo bsb_install_manager && bsb_install_manager && echo copy_manager_for_testing && copy_manager_for_testing && echo ------- && stop_bluetooth_manager && echo ------- && connect_to_bui && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
bsb_install_manager_test
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cls='printf "\033c"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias openFolder='sudo xdg-open .'
alias up='cd ..'
#use on host PC:
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
#alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && echo bsb_install_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias connect_to_bui='ssh root@192.168.1.100'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='echo bsb_install_manager && bsb_install_manager && echo copy_manager_for_testing && copy_manager_for_testing && echo ------- && stop_bluetooth_manager && echo ------- && connect_to_bui && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
alias bsb_install_bluego='stop_bluetooth_manager && ssh root@192.168.1.100 systemctl stop bluego && remount_drive && scp dbus_bluego root@192.168.1.100:/usr/bin && ssh root@192.168.1.100 systemctl start bluego && start_bluetooth_manager'
bsb_install_manager_test 
alias bsb_install_manager_test='echo copy manager for running service && bsb_install_manager && echo copy_manager_for_testing && copy_manager_for_testing && stop_bluetooth_manager && connect_to_bui && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
bsb_install_manager_test 
#Set the terminal header to show information about git
if [ "$color_prompt" = yes ]; then     export GIT_PS1_SHOWDIRTYSTATE=1;     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[00;36m\]$(__git_ps1)\[\033[00m\]\$ '; else     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '; fi
unset color_prompt force_color_prompt
cls
#Set the terminal header to show information about git
if [ "$color_prompt" = yes ]; then     export GIT_PS1_SHOWDIRTYSTATE=1;     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[00;36m\]$(__git_ps1)\[\033[00m\]\$ '; else     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '; fi
unset color_prompt force_color_prompt
bsb_install_manager_test 
connect_to_bui 
bsb_install_manager_test 
ssh-keygen -f "/home/saeed/.ssh/known_hosts" -R 192.168.1.100
bsb_install_manager_test 
cd _ALL_MY_STUFF/bosch_may
. setup_env.sh 
cd out/bui35x/
bsb_install_asf_client_test
connect_to_bui 
bsb_install_asf_client_test
. setup_env.sh 
cls
./make.sh 
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cls='printf "\033c"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias openFolder='sudo xdg-open .'
alias up='cd ..'
#use on host PC:
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
#alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
alias bsb_install_bluego='stop_bluetooth_manager && ssh root@192.168.1.100 systemctl stop bluego && remount_drive && scp dbus_bluego root@192.168.1.100:/usr/bin && ssh root@192.168.1.100 systemctl start bluego && start_bluetooth_manager'
alias connect_to_bui='ssh root@192.168.1.100'
cls
./make.sh 
rm –rf out/bui3xx/conf 
cd out/bui35x/
ll
rm -rf conf/
ll
up
./make.sh 
cd tools/mfg/
./flash.sh 
. setup_env.sh 
cls
cd services/bluetooth-manager/
git status 
git log
git difftool 
git add .
gstatus 
git log
git commit --amend 
gstatus 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager HEAD:refs/for/bui3xx-develop
git status 
git difftool 
git status 
git add .
git status 
git commit --amend 
git status 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager HEAD:refs/for/bui3xx-develop
git commit --amend 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager HEAD:refs/for/bui3xx-develop
git commit --amend 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager HEAD:refs/for/bui3xx-develop
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cls='printf "\033c"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias openFolder='sudo xdg-open .'
alias up='cd ..'
#use on host PC:
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
#alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
alias bsb_install_bluego='stop_bluetooth_manager && ssh root@192.168.1.100 systemctl stop bluego && remount_drive && scp dbus_bluego root@192.168.1.100:/usr/bin && ssh root@192.168.1.100 systemctl start bluego && start_bluetooth_manager'
alias connect_to_bui='ssh root@192.168.1.100'
cls
git status 
git log
git add .
git commit --am
git status 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager HEAD:refs/for/bui3xx-develop
git status 
git log
git status 
git diff
git status 
gstatus 
git log 
git add .
gstatus 
git commit --amend 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager HEAD:refs/for/bui3xx-develop
git add .
git commit --amend 
gstatus 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager HEAD:refs/for/bui3xx-develop
gstatus 
git commit --amend 
gstatus 
git add .
gstatus 
git commit --am
gstatus 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager HEAD:refs/for/bui3xx-develop
git commit --am
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager HEAD:refs/for/bui3xx-develop
gstatus 
git difftool 
git commit 
git add .
git commit 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager HEAD:refs/for/bui3xx-develop
git status 
git log
rstatus 
git status 
cd _ALL_MY_STUFF/bosch_may
. setup_env.sh 
cls
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cls='printf "\033c"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias openFolder='sudo xdg-open .'
alias up='cd ..'
#use on host PC:
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
#alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
alias bsb_install_bluego='stop_bluetooth_manager && ssh root@192.168.1.100 systemctl stop bluego && remount_drive && scp dbus_bluego root@192.168.1.100:/usr/bin && ssh root@192.168.1.100 systemctl start bluego && start_bluetooth_manager'
alias connect_to_bui='ssh root@192.168.1.100'
cls
rsta
rstatus 
rsync
rstatus 
cd services/bluetooth-manager/
git status 
up
cd services/services-api/
gstatus 
up
rstatus 
rsync
rstatus 
rsync
alisa rstatus_forall='repo forall -c "git status"'
alias rstatus_forall='repo forall -c "git status"'
rstatus_forall 
cls
rstatus_forall 
cls
rstatus_forall 
cd _ALL_MY_STUFF/bosch_may
. setup_env.sh 
cd out/bui35x/
bitbake bluetooth-manager
bitbake -b bluetooth-manager_
grep "BluetoothStatusAdvertising" -r .
cd ..
up
cd services/bluetooth-manager/
grep "BluetoothStatusAdvertising" -r .
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cls='printf "\033c"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias openFolder='sudo xdg-open .'
alias up='cd ..'
#use on host PC:
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
#alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
alias bsb_install_bluego='stop_bluetooth_manager && ssh root@192.168.1.100 systemctl stop bluego && remount_drive && scp dbus_bluego root@192.168.1.100:/usr/bin && ssh root@192.168.1.100 systemctl start bluego && start_bluetooth_manager'
alias connect_to_bui='ssh root@192.168.1.100'
cls
cd ..
upp
uup
up
cd out/bui35x/
bitbake -b bluetooth-manager_
bitbake bluetooth-manager
up
cd out/bui35x/
bitbake -b bluetooth-manager_
up
. ste
. setup_env.sh 
cd out/bui35x/
bitbake -b bluetooth-manager_
. ste
. setup_env.sh 
csls
cls
rstatus 
cd os/libdbushelper/
git status 
git difftool 
git status 
git stash list
git stash
rstatus 
gstatus 
git log
git stash pop
git difftool 
git status 
git commit --amend 
git status 
git stash list
git stash
git status 
grebasei 
git rebase
git log
git status 
git stash pop
git commit 
git add .
git commit 
git stash list
gstatus 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager HEAD:refs/for/bui3xx-develop
git log
repo sync .
git log
repo sync .
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager HEAD:refs/for/bui3xx-develop
git status 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/os/libdbushelper HEAD:refs/drafts/bui3xx-develop
rstatus 
git log 
gstatus 
git fetch ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager refs/changes/60/5160/4 && git cherry-pick FETCH_HEAD
gstatus 
git cherry-pick --abort 
gstatus 
git fetch ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/os/libdbushelper refs/changes/59/5159/3 && git cherry-pick FETCH_HEAD
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cls='printf "\033c"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias openFolder='sudo xdg-open .'
alias up='cd ..'
#use on host PC:
alias start_dlt='cd tools/dlt-viewer-hack && sudo LD_LIBRARY_PATH=. ./dlt_viewer && cd ../..'
alias location='bsb startdebug com.bosch.connectivity.location'
alias location_unittest='bsb startdebug com.bosch.connectivity.locationunittest'
alias wifi='bsb startdebug com.bosch.connectivity.wifi'
alias wifi_unittest='bsb startdebug com.bosch.connectivity.wifiunittest'
alias ble='bsb startdebug com.bosch.connectivity.bluetooth'
alias ble_unittest='bsb startdebug com.bosch.connectivity.bleunittest'
alias stop_app='bsb stopdebug'
# Alternative to 'bsb install' and 'bsb startDebug'
alias copyScreens='scp ~/_ALL_MY_STUFF/screens.json root@192.168.1.100:/data/system/db/screens.json'
alias restartSSremote='ssh root@192.168.1.100 systemctl restart system-server'
alias rebootbui='ssh root@192.168.1.100 reboot'
alias bsb_install_1='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/ && scp connectivity-test-app.bpk root@192.168.1.100:/data/system/install-cache/ && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias bsb_install_2='copyScreens && croot && cd out/bui35x/ && bitbake -c cleanall connectivity-test-app && bitbake connectivity-test-app && cd ./../SDK/tools && ./bsb install /home/saeed/_ALL_MY_STUFF/bosch_may/out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/connectivity-test-app/1.0.0-r0/image/default/system/install-cache/connectivity-test-app.bpk && croot && copyScreens && restartSSremote' # && sleep 5 && restartSSremote'
alias make_loop='for i in {1..3}; do . proxyoff; ./make.sh; . proxyon; ./make.sh; done'
#alias flash_bosch='sudo dd if=/home/saeed/_ALL_MY_STUFF/bui3xx.sdcard of=/dev/sdd bs=1M && sync'
alias flash_me='croot && cd tools/mfg && ./flash.sh'
alias make_me='croot && ./make.sh'
alias croott='cd /home/saeed/_ALL_MY_STUFF/bosch_ref/'
alias transfer='croott && scp -r ./out/bui35x/tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:~ && scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:~'
alias compileandtransfer='cd out/bui35x/ && bitbake bluetooth-manager-extension && transfer && cd ../..'
# Save uncommited changes to file on predefined place (stash)
alias stash_me='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
# Restore patch from file from predefined place (stash)
# GIT COMMANDS
alias grebasei='git rebase -i HEAD~5'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glog='git log'
# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'
alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager
alias bsb_install_ext='croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'
alias install_all='install_manager && install_html && install_ext'
alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'
alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'
alias bsb_install_manager_test='bsb_install_manager && copy_manager_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
alias bsb_install_bluego='stop_bluetooth_manager && ssh root@192.168.1.100 systemctl stop bluego && remount_drive && scp dbus_bluego root@192.168.1.100:/usr/bin && ssh root@192.168.1.100 systemctl start bluego && start_bluetooth_manager'
alias connect_to_bui='ssh root@192.168.1.100'
cls
gstatus 
git log
git status 
git log
grebasei 
git log
git commit --amend 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/os/libdbushelper HEAD:refs/for/bui3xx-develop
git rebase --continue
git log
git status 
git difftool 
git status 
git diff
git status 
git log
git commit --am
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/os/libdbushelper HEAD:refs/for/bui3xx-develop
git add .
git status 
git commit --am
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/os/libdbushelper HEAD:refs/for/bui3xx-develop
git status 
git log
git status 
git log
git fetch
git status 
grebasei 
git status 
git rebase
git status 
git log
git status 
git diff
gstatus 
git add .
git commit 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/os/libdbushelper HEAD:refs/for/bui3xx-develop
sudo ./eclipse 
bg
cd _ALL_MY_STUFF/bosch_may/services/bluetooth-manager/
cd _ALL_MY_STUFF/bosch_may/services/bluetooth-manager/
git status 
cd _ALL_MY_STUFF/bosch_may
cd services/bluetooth-manager/
cd _ALL_MY_STUFF/bosch_may
cd services/bluetooth-manager/
git status 
alias
alias | grep croot
cls
alias | grep croot
cd _ALL_MY_STUFF/bosch_may
. setup_env.sh 
cls
cd appfw/extensions/bluetoothmanager/
git status 
git diff
git difftool 
git commit 
git add .
git commit 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/appfw/cefextensions/bluetooth-manager HEAD:refs/for/bui3xx-develop
git fetch ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/appfw/cefextensions/bluetooth-manager refs/changes/75/5175/5 && git cherry-pick FETCH_HEAD
gstatus 
git add src/BluetoothManagerExtension.cpp
git cherry-pick --continue 
git log
grebasei 
gstatus 
grebasei 
git log
htop
rstatus 
cls
rstatus 
cls
rstatus 
git stash list
git stash
rstatus 
git branch 
git checkout -b s_btextension_new bosch-gerrit/bui3xx-develop 
. setup_env.sh 
cd services/bluetooth-manager/
git status 
gstatus 
grebasei 
gstatus 
git fetch ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager refs/changes/63/5263/1 && git cherry-pick FETCH_HEAD
gstatus 
git stash
grebasei 
git fetch ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager refs/changes/63/5263/2 && git cherry-pick FETCH_HEAD
git stash list
git stash pop
git stash list
git status 
git difftool 
git log
git stash list
git stash
grebasei 
git stash pop
git difftool 
git status 
git add 
git add src/BluetoothManager.cpp
git add src/DBusAgentServer.cpp
git add src/DBusClient.cpp
git status 
git commit 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/os/libdbushelper HEAD:refs/for/bui3xx-develop
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager HEAD:refs/for/bui3xx-develop
cls
gstatus 
git add src/DeviceDatabase.cpp
gstatus 
git commit 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager HEAD:refs/for/bui3xx-develop
git log
gstatus 
git fetch ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager refs/changes/50/5250/1 && git cherry-pick FETCH_HEAD
git stash
git fetch ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager refs/changes/50/5250/1 && git cherry-pick FETCH_HEAD
git stash pop
git log
git fetch ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager refs/changes/24/5224/4 && git cherry-pick FETCH_HEAD
gstatus 
git stash list
git stash drop stash@{0}
git stash list
git stash
gstatus 
git fetch ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager refs/changes/24/5224/4 && git cherry-pick FETCH_HEAD
gstatus 
git cherry-pick --abort
gstatus 
git fetch ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager refs/changes/45/5145/18 && git cherry-pick FETCH_HEAD
gstatus 
git status 
git rebase
grebasei 
gstatus 
git add src/DeviceDatabase.cpp
git commit --amend 
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager HEAD:refs/for/bui3xx-develop
gstatus 
git rebase --continue 
git log
gstatus 
git difftool 
git log
gstatus 
git stash 
git stash drop stash@{0}
git stash list
git status 
git stash pop
gstatus 
git git add src/BluetoothManager.cpp
git add src/BluetoothManager.cpp
gstatus 
git reset
gstatus 
git difftool 
gstatus 
git stash list
git stash
git stash pop
git stash
git checkout -b s_blmanager_new bosch-gerrit/bui3xx-develop 
. setup_env.sh 
cls
cd os/libdbushelper/
gstatus 
git diff
git add .
git diff
gstatus 
git commit
git commit --am
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/os/libdbushelper HEAD:refs/for/bui3xx-develop
cls
gstatus 
cd
cd _ALL_MY_STUFF/bosch_may
cd apps/connectivity-test-app/
git fetch ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/apps/connectivity-test refs/changes/53/5253/1 && git cherry-pick FETCH_HEAD
gstatus 
git cherry-pick --continue
gstatus 
git log
gstatus 
git log
gstatus 
up
cd appfw/js-api/
git log
git fetch ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/appfw/js-api refs/changes/86/5086/9 && git cherry-pick FETCH_HEAD
up
cd os/libdbushelper/
gstatus 
git difftool 
git stash list
git stash
git stash drop stash@{0}
gstatus 
git stash
git stash list
git checkout -b s_libdbushelper_new bosch-gerrit/bui3xx-develop 
cd _ALL_MY_STUFF/bosch_may
. setup_env.sh 
cd out/bui35x/
bitbake -b bluetooth-manager_
bitbake -b bluetooth-manager_ | grep unused
bitbake -b bluetooth-manager_
bitbake -b bluetooth-manager_ | grep -Werror
bitbake -b bluetooth-manager_ | grep Werror
bitbake -b bluetooth-manager_ | grep "no return"
bitbake -b bluetooth-manager_
bitbake -b bluetooth-manager_ | grep AdapterIf::StopDiscove
bitbake -b bluetooth-manager_
bitbake bluetooth-manager
bitbake bluetooth-manager | destructor
bitbake bluetooth-manager | grep destructor
bitbake -b bluetooth-manager_
cls
bitbake -b bluetooth-manager_
bitbake -b bluetooth-manager_ | grep warning
bitbake -b bluetooth-manager_
up
cd services/bluetooth-manager/
grep "FILTER" -r .
cd services/bluetooth-manager/
cd
cd _ALL_MY_STUFF/bosch_may
cd out/bui35x/
bitbake -b bluetooth-manager_
cd _ALL_MY_STUFF/bosch_may
bsb_install_manager_test 
. setup_env.sh 
bsb_install_manager_test 
bsb_install_manager
ssh-keygen -f "/home/saeed/.ssh/known_hosts" -R 192.168.1.100
connect_to_bui 
ssh-keygen -f "/home/saeed/.ssh/known_hosts" -R 192.168.1.100
bsb_install_manager
cd _ALL_MY_STUFF/bosch_may
. setup_env.sh 
cls
connect_to_bui 
ssh-keygen -f "/home/saeed/.ssh/known_hosts" -R 192.168.1.100
connect_to_bui 
bsb_install_asf_client_test 
sdf
rsync
. setup_env.sh 
./make.sh 
openFolder 
./make.sh 
. setup_env.sh 
./make.sh 
rsync
rstatus
rsync
. setup_env.sh 
./make.sh cleanall
./make.sh -cleanall
./make.sh -clean
cd _ALL_MY_STUFF/
openFolder 
alias asd='export BOSCH_REPO_DIR=`pwd` && cpoot() { cd $BOSCH_REPO_DIR/$1 }'
cpoot
asd; .; sdf
alias asd='export BOSCH_REPO_DIR=pwd && cpoot() { cd $BOSCH_REPO_DIR/$1 }'
asd; asd
alias asd='export BOSCH_REPO_DIR=`pwd` cpoot() { cd $BOSCH_REPO_DIR/$1 }'
asd
start_dlt 
cd _ALL_MY_STUFF/bosch_may
start_dlt 
