#!/bin/bash
# This is the entry point for configuring the system.
#####################################################
INSTALL_DIR=`pwd`

source setup/functions.sh # load our functions

if [ ! -f /usr/bin/dialog ] || [ ! -f /usr/bin/python3 ] || [ ! -f /usr/bin/pip3 ]; then
	echo Installing packages needed for setup...
	apt-get -q -q update
	apt_get_quiet install dialog python3 python3-pip  || exit 1
fi

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
