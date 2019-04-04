############################ Set History size ###################################
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=1000000

############################ Command Seperator ##################################
if [ -f "$HOME/.bash_ps1" ]; then
. "$HOME/.bash_ps1"
fi

########### Set the terminal header to show information about git ############
#Set the terminal header to show information about git
#if [ "$color_prompt" = yes ]; then
    #Enable to show if there are non-commited changes (*) or non-staged changes (+)
    export GIT_PS1_SHOWDIRTYSTATE=1
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[00;36m\]$(__git_ps1)\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
unset color_prompt force_color_prompt

################################## BorgWarner ###############################
alias cd_shared_repo='cd ~/Desktop/BorgWarner/repo/SMG000_P739_92/CC_ECC/target'

############################ some more ls aliases ###########################
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

################################ ON ALL MACHINES #################################
# ALL MACHINES:
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
# GIT COMMANDS
alias gbranch='git branch'
alias grebasei='git rebase -i HEAD~25'
alias gcontinue='git rebase --continue'
alias gabort='git rebase --abort'
alias gdifftool='git difftool'
alias gdifftool_latest_commit='git difftool HEAD~0 ^HEAD~1'
alias gdifftool_latest_commit_x2='git difftool HEAD~1 ^HEAD~2'
alias gdifftool_latest_commit_x3='git difftool HEAD~2 ^HEAD~3'
alias gamend='git commit --amend'
alias gstatus='git status'
alias glist='git stash list'
alias gpop='git stash pop'
alias gstore='git commit -m "stashed !!!!"'
alias grestore='git reset HEAD~1'
alias gundocommit='git reset HEAD~1'
alias gtempchanges='git diff | grep "change back" -A5 -B5'
alias glog='git log'
alias glogvirsualize='git log --graph --decorate --oneline --full-history'
alias glogdate='git log --format=fuller'
## Save uncommited changes to file on predefined place (stash)
alias save_diff='git diff > /home/saeed/_ALL_MY_STUFF/_PATCH/_latest.diff'
## Restore patch from file from predefined place (stash)

# REPO COMMANDS
alias rstatus='repo status -j33'
alias rgstatus="repo forall -c 'git status'"
alias rsync='repo sync -j33 -f'
alias rstatus_forall='repo forall -c "git status"'

########################### ENGELBERT RELATED ALIASES ############################

# ENGELBERT:
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

# Aliases for installing ext,manager,html
alias remount_drive='ssh root@192.168.1.100 mount -o remount,rw /'
alias stop_system_server='ssh root@192.168.1.100 systemctl stop system-server'
alias stop_bluetooth_manager='ssh root@192.168.1.100 systemctl stop bluetooth-manager'
alias start_system_server='ssh root@192.168.1.100 systemctl start system-server'
alias start_bluetooth_manager='ssh root@192.168.1.100 systemctl start bluetooth-manager'

alias copy_ext='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-extension/1.0.0-r0/package/usr/lib/* root@192.168.1.100:/usr/'
alias copy_html='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/html-runtime/1.0.0-r0/packages-split/html-runtime/* root@192.168.1.100:/usr/bin/' # for installing extension and html-runtime
alias copy_manager='scp -r ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/package/usr/bin/BluetoothServer root@192.168.1.100:/usr/bin/' # for installing manager

alias bsb_install_ext='copyScreens && croot && cd out/bui35x && bitbake bluetooth-manager-extension && remount_drive && stop_system_server && copy_ext && start_system_server'
alias bsb_install_html='copyScreens && croot && cd out/bui35x && bitbake html-runtime && remount_drive && stop_system_server && copy_html && start_system_server'
alias bsb_install_manager='copyScreens && croot && cd out/bui35x && bitbake bluetooth-manager && remount_drive && stop_bluetooth_manager && echo bsb_install_manager && copy_manager && start_bluetooth_manager'
alias bsb_install_manager_asf='copyScreens && croot && cd out/bui35x && bitbake bluetooth-manager-asf-test && remount_drive && stop_bluetooth_manager && copy_manager && start_bluetooth_manager'

alias install_all='install_manager && install_html && install_ext'

alias restart_btm='stop_bluetooth_manager && start_bluetooth_manager'
alias restart_syss='ssh root@192.168.1.100 systemctl restart system-server'


alias connect_to_bui='ssh root@192.168.1.100'

alias copy_asf_client_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager-asf-test/1.0.0-r0/image/usr/bin/BluetoothManagerClient root@192.168.1.100:/home/root/'
alias copy_manager_for_testing='scp ./tmp/work/cortexa9-vfp-neon-poky-linux-gnueabi/bluetooth-manager/1.0.0-r0/image/usr/bin/BluetoothServer root@192.168.1.100:/home/root/'

alias bsb_install_manager_test='echo copy manager for running service && bsb_install_manager && echo copy_manager_for_testing && copy_manager_for_testing && stop_bluetooth_manager && connect_to_bui && cd ~ && ./BluetoothServer'
alias bsb_install_asf_client_test='bsb_install_manager_asf && copy_asf_client_for_testing && stop_bluetooth_manager && ssh root@192.168.1.100 && cd ~ && ./BluetoothManagerClient'
alias bsb_install_bluego='stop_bluetooth_manager && ssh root@192.168.1.100 systemctl stop bluego && remount_drive && scp dbus_bluego root@192.168.1.100:/usr/bin && ssh root@192.168.1.100 systemctl start bluego && start_bluetooth_manager'

#use on evaluation board:
alias cls='printf "\033c"'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias rm_debug='rm /usr/bin/cef3/debug.log && echo debug.log removed'
alias restart='systemctl restart system-server && systemctl restart bsb && echo system-server and bsb restarted.'
alias app_inst_check='grep com.bosch.connectivity /data/system/db/applications.json'
alias uninstall='rm /data/system/install-cache/connectivity-test-app.bpk'
alias cef_JS_Script_Output='cat /usr/bin/cef3/debug.log | grep connectivity'
alias see_all_apps='grep "id" /data/system/db/applications.json'
alias portforward='ssh -L 0.0.0.0:9223:localhost:9222 localhost'
alias readwrite='mount -o remount,rw /'
alias restartbsb='systemctl restart bsb'
alias restartss='systemctl restart system-server'
alias installtransfer='mount -o remount,rw / && systemctl stop system-server && cp -r usr/* /usr/ && systemctl start system-server && systemctl stop bluetooth-manager && cp BluetoothServer /usr/bin && systemctl start bluetooth-manager'

############################# ISEE RELATED ALIASES #################################

alias mountShared='sudo && sudo mount -t vboxsf D_DRIVE /media/D_DRIVE/ && sudo mount -t vboxsf Desktop /media/Desktop/'
alias croot='cd /home/saeed/Desktop/PROJ_ISEE/git_1/nrf52_sdk/'

####################################################################################

