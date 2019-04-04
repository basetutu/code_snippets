

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
