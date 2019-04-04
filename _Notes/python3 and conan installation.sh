

# Setup_build_server
# ====================

#!!!
# --user can only be used outside of a virtual environment (virtualenv)
# If inside, use 'sudo' if needed!
# sudo cannot be used inside a virtualenv!

sudo apt-get update -y
sudo apt-get upgrade -y 
sudo apt-get autoremove -y
sudo apt-get autoclean -y

python3 --version

sudo apt-get install python3 -y
sudo apt-get install python3-pip -y
sudo apt-get install python3-setuptools -y

python3 -m pip --version
python3 -m pip install --user --upgrade pip

python3 -m pip install --user conan
python3 -m pip install --user --upgrade conan

python3 -m pip install --user virtualenv
python3 -m pip install --user --upgrade virtualenv

# if conan installation fails:
#curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
#python3.4 get-pip.py
#pip install conan

# Install the binary if needed
# https://conan.io/downloads.html

# Activates the virtual environment
source env/bin/activate
# write 'deactivate' to get out of the virtual environment

# Initial config
conan

# You can now run your scripts...
