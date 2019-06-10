

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
sudo docker run --rm -it -v ~/.ssh:/home/builder/.ssh -v ~/yocto-cache-r3:/mnt/yocto-cache -v ~/repo:/repo --workdir=/repo                     beijer/yocto # x2
sudo docker run --rm -it -v ~/.ssh:/home/builder/.ssh -v ~/yocto-cache-r3:/mnt/yocto-cache -v ~/krogoth-r3:/repo --workdir=/repo               beijer/yocto
sudo docker run --rm -it -v ~/.ssh:/home/builder/.ssh -v ~/yocto-cache-r3:/mnt/yocto-cache -v ~/krogoth-r3-chromium:/repo --workdir=/repo      beijer/yocto
sudo docker run --rm -it -v ~/.ssh:/home/builder/.ssh -v ~/yocto-cache-r3:/mnt/yocto-cache -v ~/krogoth-r3-poky_no_fork:/repo --workdir=/repo  beijer/yocto
sudo docker run --rm -it -v ~/.ssh:/home/builder/.ssh -v ~/yocto-cache-r3:/mnt/yocto-cache -v ~/krogoth-r3-poky_up_browser_rm_unused_patch:/repo --workdir=/repo beijer/yocto
sudo docker run --rm -it -v ~/.ssh:/home/builder/.ssh -v ~/yocto-cache-r3:/mnt/yocto-cache -v ~/chromium_on_poky:/repo  --workdir=/repo        beijer/yocto

source sources/poky/oe-init-build-env project
export MACHINE=imx4a-7  # For krogoth-x2 not r3
bitbake beijer-image-dev
bitbake beijer-image
bitbake beijer-image-dotnetcore
bitbake beijer-mini-image

ulimit -n 4096 # Raise the number of open file descriptors for the shell

export MACHINE=imx6qdlsabresd
export MACHINE=qemux86
bitbake core-image-soto

# Use this line in the docker to start the bitbake build for krogoth-r3 and for development
./home/builder/.ssh/build.sh r3 dev
./home/builder/.ssh/build.sh x2 dev


docker build -t beijer/yocto --file docker-images/Dockerfile-yocto docker-images


# Skip dependencies
bitbake -b chromium_48.0.2548.0
# Build dependencies
bitbake chromium_48.0.2548.0



-------------------------


* working on k_beijer_layers

* seperated meta-beijer into two folders
** meta-myarm (bsp)
** meta-general-layer (webpanel)

Modify the layer settings of webpanel to compelete the job...
Use a script tool if it exists.



