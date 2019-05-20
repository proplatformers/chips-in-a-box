#!/bin/bash
# This is the entry point for configuring the system.
#####################################################
INSTALL_DIR=`pwd`
#sudo apt-get update
#sudo apt-get -y install libgomp1 jq dialog
source setup/functions.sh # load our functions
mkdir -p ~/bin

# Put a start script in a global location. We tell the user to run 'chipsinabox'
# in the first dialog prompt, so we should do this before that starts.
cat > ~/bin/chipsinabox << EOF;
#!/bin/bash
cd `pwd`
source setup/start.sh
EOF
chmod +x ~/bin/chipsinabox

source setup/console.sh 
echo
echo "-----------------------------------------------"
echo
echo Your chips-in-a-box is running below
echo
ps aux | grep chipsd | grep -v grep 
