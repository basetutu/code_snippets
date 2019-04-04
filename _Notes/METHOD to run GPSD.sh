# Start GPSD as a service
sudo service gpsd start
# Start GPSD as a process on a specific device
gpsd /dev/ttyACM0 

# Check to see if the proccess or service is running
ps -A | grep gps

# Three different clients
cgps
gpsmon 
xgps

# How to stop a process
kill 4867
