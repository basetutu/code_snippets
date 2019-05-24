------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------

# How to write a bash script

## To create a bash script, you place #!/bin/bash at the top of the file.
## Then, change the permissions on the file to make it executable:
chmod u+x scriptname
# Special variables:
echo $0      # prints the script name
echo $1      # prints the first argument
echo $2      # prints the second argument
echo $9      # prints the ninth argument
echo $10     # prints the first argument, followed by 0 
echo ${10}   # prints the tenth argument
echo $#      # prints the number of arguments
echo $?      # prints the "exit status" of the previously executed process.
echo $$      # prints the process id of current shell.
## To reference the value of a variable, use a dollar sign, $:
## It is sometimes necessary to wrap a reference to a variable is braces:
echo ${foo} # prints $foo
## You can start using any variable as an array:
foo[0]="first"  # sets the first element to "first"
foo[1]="second" # sets the second element to "second"
## You can also use parentheses to create an array:
foo=("a a a" "b b b" "c c c")
echo ${foo[2]}  # prints "c c c"
echo $foo       # prints "a a a"
## To access all of the values in an array, use the special subscript @ or *:
array=(a b c)
echo $array       # prints a
echo ${array[@]}  # prints a b c
echo ${array[*]}  # prints a b c
## To copy an array, use subscript @, surround it with quotes, and surround that with parentheses:
foo=(a b c)
bar=("${foo[@]}")
echo ${bar[1]}    # prints b

## Read more at:
http://matt.might.net/articles/bash-by-example/

------------------------------------------------

#Log in på device i två olika fönster med 
ssh root@192.168.1.100



# How to build the FW
# ... Go to the makefile folder
make -j90

# How to erase the device over SWD
~/_PROGRAMS/nRF5x-Command-Line-Tools_9_7_3_Linux-x86_64/nrfjprog/nrfjprog --family nRF52 -e
# How to program the device over SWD
~/_PROGRAMS/nRF5x-Command-Line-Tools_9_7_3_Linux-x86_64/nrfjprog/nrfjprog --family nRF52 --program _build/nrf52840_xxaa.hex 
# How to run the FW on device over SWD
~/_PROGRAMS/nRF5x-Command-Line-Tools_9_7_3_Linux-x86_64/nrfjprog/nrfjprog --family nRF52 -r




sudo putty /dev/ttyUSB0 -serial -sercfg 9600,8,n,1,N
sudo minicom -s
use connected_device.sh


# To start the Android debug log prints on windows
adb logcat debug:V *:S


------------------------------------------------
# JTAG commands

# To enter JTAG command line
JLinkExe -device nRF52

# To connect
connect

# Choose interface with S=SWD, J=JTAG
S, J

# r for reset and halt
# g for run
# q for quit

------------------------------------------------
# Make commands

# To find the location of the make file installation
which make
# To compile a makefile
make -j8
# To clean a build
make clean

# Create a build system on Linux
# Needed libs
sudo apt-get install gcc-arm-none-eabi
sudo apt-get install make
sudo apt-get install build-essential checkinstall
# See versions
arm-none-eabi-gcc --version
make -v

------------------------------------------------
date -s "2017-03-03 15:49"
date

ps -A | grep LocationServer
ps -A | grep WifiServer

# Copy data from target to PC
scp root@192.168.1.100:/data/system/db/screens.json ~/_ALL_MY_STUFF/

# How to search for strings inside of files
grep "text" -r -n --include=*.h .
grep "text" -r -n --include="*.h" --include="*.c" .
grep "text" -r -n --include="*.*" --include="*.c" --exclude="*.svn-base" .
grep -Rni DbusMsgCallMethod *

# How to search for files and see their properties
find . -iname connectivity*.bpk -ls

# Use ack-grep to highlight text
find --help | ack-grep --passthru -i 'name'           # ignore case
find --help | ack-grep --passthru --smart-case 'name' # ignore case if all lower-case
find --help | ack-grep --passthru --smart-case 'NAME' # do not ignore case

# Watch the top 5 highest CPU intensive processes every 2 seconds
watch "ps aux | sort -nrk 3,3 | head -n 5"

# Making a file executable
chmod +x .bashrc


------------------------------------------------

# Create file with content
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

------------------------------------------------
# Mount windows shared folders in virtualbox											

sudo mount -t vboxsf D_DRIVE /media/sf_D_DRIVE/
sudo mount -t vboxsf Desktop /media/sf_Desktop/
sudo mount -t vboxsf Z_DRIVE /media/sf_Z_DRIVE/

------------------------------------------------
# Searching
find <path> -iname <text>

#Wildcards do work here

------------------------------------------------

// to read a textfile:
cat <filename>

less <filename>

vi <filename>

------------------------------------------------

tree -d -L 2 -A

ls usb
ls /ttyUSB*

lbb

file <filename>

------------------------------------------------
# Flash a CDCARD with a certain file that is in current directory
sudo dd if=bui3xx-image-imx6dlsabreauto-cm-20161122134457.rootfs.sdcard of=/dev/sdb bs=1M && sync

------------------------------------------------

# Output list of all proccess and search for rslsync
ps aux | grep rslsync

# Get all info about the running proccess
cat /proc/2523/status
# status is one of the options
# 2523 id the PID-id of the proccess
cat /proc/version
# browse the folder for more

cat /etc/passwd

------------------------------------------------

# See resource use for each process
top
or
htop

# See network activity for each process
sudo jnettop -i eth0
------------------------------------------------

# Goes to the user directory
cd ~
# Goes to root
cd /
# Goes to the location of the source.list file
cd /etc/apt/
------------------------------------------------

# displays all access right (permissions) for all files and folders in current directory
ls -la
or
ls -l

# Display the access rights to the folder 'Desktop', even show user and group it belongs to
ls -ld Desktop/
## The permission of the folder itself
ls -d Desktop/
## The permission of the folder's content
ls -l Desktop/

# Show only specific files
ll *.sdcard

# Adds the execution access right to the file
sudo chmod +x <filename>

# Gives permission to the group 'g' to have write access to the folder
chmod g+w Desktop/

# Give full aces rights to current folder (permission)
sudo chmod a+rwx .

# Create a docker-group and add docker and the current user to the group to avoid 'sudo' (permission)
sudo groupadd docker
sudo usermod -aG docker $USER

------------------------------------------------
# Adds the execution access right to the file
sudo chmod a+x ~/bin/proxyon

# Gives access rights to all and everyone
sudo chmod 777 ~/bin/proxyon

ll

------------------------------------------------

# To make any changes done 
source ./setup.sh

# eqvivalent to
. setup.sh

------------------------------------------------
# Shows all mounted drives and where they are mounted to
mount

# Make the owner of the folder "developer/" to the user called "developer" and also for its group
sudo chown developer:developer developer/

# Adds the user called developer to the group called vboxsf
sudo adduser developer vboxsf

------------------------------------------------
