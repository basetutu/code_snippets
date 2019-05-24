

git tag -a krogoth-15.0.1 f5da2a5913 -m "Message here"



# How to init repo with the manifest git repository
repo init -u ssh://tfs.beijerelectronics.com/HmiDev/Git/_git/manifest -b krogoth-x2
repo init -u ssh://tfs.beijerelectronics.com/HmiDev/Git/_git/manifest -b krogoth-r3
repo sync



# How to install repo
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
export PATH=~/bin:$PATH


# Flash SD-card in linux
cd ~/repo/project/tmp/deploy/images/imx4a-7
sudo dd if=beijer-image-dev-imx4a-7-20190521153259.rootfs.sdcard-beijer of=/dev/sdb1 bs=1M && sync


# How to build with docker
sudo docker run -it -v ~/.ssh:/home/builder/.ssh -v ~/yocto-cache-x2:/mnt/yocto-cache          -v ~/repo:/repo beijer/yocto
sudo docker run -it -v ~/.ssh:/home/builder/.ssh -v ~/yocto-cache-r3:/mnt/yocto-cache          -v ~/krogoth-r3:/repo beijer/yocto
sudo docker run -it -v ~/.ssh:/home/builder/.ssh -v ~/yocto-cache-r3-chromium:/mnt/yocto-cache -v ~/krogoth-r3-chromium:/repo beijer/yocto
sudo docker run -it -v ~/.ssh:/home/builder/.ssh -v ~/yocto-cache-r3-poky_no_fork:/mnt/yocto-cache -v ~/krogoth-r3-poky_no_fork:/repo beijer/yocto


source sources/poky/oe-init-build-env project
export MACHINE=imx4a-7  # For krogoth-x2 not r3
bitbake beijer-image-dev

# Use this line in the docker to start the bitbake build for krogoth-r3 and for development
./home/builder/.ssh/build.sh r3 dev
./home/builder/.ssh/build.sh x2 dev


# Skip dependencies
bitbake -b chromium_48.0.2548.0
# Build dependencies
bitbake chromium_48.0.2548.0
