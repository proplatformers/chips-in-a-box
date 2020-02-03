function submenu_install_chips {
STAGE="Install CHIPS"

while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console - ${STAGE}" \
--title "[ C A K E S H O P - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
CHIPS "CHIPS - install the decentralized peer-to-peer blockchain backend" \
LIGHTNING "LIGHTNING - install lightning for cheap microtransactions" \
PANGEA "PANGEA - install the front end GUI web application" \
BETREST "BET - install the pangea backend rest_dev branch" \
STARTSERVING "Start serving the front end" \
Back "Go back in the menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
        LIGHTNING) install_lightning;;
        CHIPS) install_chips;;
        PANGEA) install_pangea;;
	BETREST) install_bet_rest;;
	BETPOKER) install_bet_poker;;
	STARTSERVING) start_frontend;;
        Back) echo "Bye"; break;;
esac
done
}

function install_lightning {
if [ ! -d $HOME/lightning ] ; then
	cd $HOME
	echo "Cloning the lightning repository from https://github.com/jl777/lightning"
	sleep 2
	hide_output git clone https://github.com/jl777/lightning
	cd lightning
	echo "Building lightning...this may take 1 or 2 minutes"
	sleep 2
	hide_output make
	echo "Linking lightning to /usr/local/bin - might need sudo rights"
	sleep 2
	sudo ln -sf ${PWD}/lightningd/lightningd /usr/local/bin/lightningd
	sudo ln -sf ${PWD}/cli/lightning-cli /usr/local/bin/lightning-cli
else
	echo "Lightning src exists"
	sleep 1
	message_box "Src exists" "Lightning src exists"
fi
}

function install_chips {
	echo "Installing chips begin"
if [ ! -d $HOME/chips3 ] ; then
	cd $HOME
	echo "Installing CHIPS dependencies...might need sudo to apt-get install some packages"
	sleep 2
	sudo apt-get -y install software-properties-common autoconf git wget tmux build-essential libtool libprotobuf-c-dev libgmp-dev libsqlite3-dev python python3 zip jq libevent-dev pkg-config libssl-dev libcurl4-gnutls-dev cmake libboost-all-dev automake jq libwebsockets-dev
	echo "Cloning chips source code from https://github.com/jl777/chips3"
	sleep 2
	hide_output git clone https://github.com/jl777/chips3.git
	cd chips3
	CHIPSDIR=$PWD
	echo "CHIPSDIR is $CHIPSDIR"
	sleep 2
	#git checkout dev
	hide_output wget https://github.com/imylomylo/docker-chipsd-lightning/raw/master/db-4.8.30.NC.tar.gz
	hide_output tar zxvf db-4.8.30.NC.tar.gz
	cd db-4.8.30.NC/build_unix
	echo "Configuring the build system for CHIPS leveldb compilation"
	sleep 2
	hide_output ../dist/configure -enable-cxx -disable-shared -with-pic -prefix=${CHIPSDIR}/db4
	echo "Building CHIPS leveldb - this will take 1 minute or less"
	sleep 2
	hide_output make -j2
	make install
	cd $HOME
	cd chips3
	echo "Generating configuration for CHIPS build system"
	sleep 2
	hide_output ./autogen.sh
	echo "Configuring CHIPS build system"
	sleep 2
	hide_output ./configure LDFLAGS="-L${CHIPSDIR}/db4/lib/" CPPFLAGS="-I${CHIPSDIR}/db4/include/" -without-gui -without-miniupnpc --disable-tests --disable-bench --with-gui=no && \
	echo "Building CHIPS - this will take 5 minutes"
	sleep 2
	hide_output make -j2
	echo "Linking chipsd and chips-cli to /usr/local/bin - might ask for sudo rights"
	sleep 2
	sudo ln -sf ${PWD}/src/chipsd /usr/local/bin/chipsd
	sudo ln -sf ${PWD}/src/chips-cli /usr/local/bin/chips-cli
	echo "Making a default config files at $HOME/.chips/chips.conf"
	mkdir -p $HOME/.chips
	echo "rpcuser=userighkjasdf98h" > $HOME/.chips/chips.conf
	echo "rpcpassword=pass87uy2n0" >> $HOME/.chips/chips.conf
	echo "txindex=1" >> $HOME/.chips/chips.conf
	echo "daemon=1" >> $HOME/.chips/chips.conf
	echo "addnode=5.9.253.195" >> $HOME/.chips/chips.conf
	echo "addnode=74.208.210.191" >>$HOME/.chips/chips.conf
else
	echo "chips3 already tried installing before?"
	sleep 1
	message_box "Src exists" "chips3 already tried installing before?"
fi
}

function install_pangea {
if [ ! -d $HOME/pangea-poker-frontend ] ; then
	cd $HOME
	hide_output git clone https://github.com/sg777/pangea-poker-frontend.git
else
	message_box "Src already exists" "Need to handle this in the future"
fi
}

function install_bet_rest {
if [ ! -d $HOME/bet ] ; then
	cd $HOME
	echo "Installing some system dependencies - might ask for sudo password"
	sleep 3
	sudo apt-get install -y software-properties-common autoconf git build-essential libtool libprotobuf-c-dev libgmp-dev libsqlite3-dev python python3 zip jq libevent-dev pkg-config libssl-dev libcurl4-gnutls-dev cmake ninja-build libsqlite3-dev libgmp3-dev
	cd $HOME
	git clone https://github.com/sg777/libwebsockets.git
	echo "Building libwebsockets, 1-2 minutes max.  Might need sudo password"
	sleep 2
	cd libwebsockets
	mkdir build
	cd build
	cmake ..
	make && sudo make install
	sudo ldconfig /usr/local/lib
	echo "Cloning nng"
	sleep 2
	cd $HOME
	git clone https://github.com/nanomsg/nng.git
	cd nng
	mkdir build
	cd build
	echo "Building nng"
	cmake -G Ninja ..
	ninja
	ninja test
	sudo ninja install
	echo "Cloning sg777's bet repo from https://github.com/sg777/bet"
	sleep 2
	cd $HOME
	git clone https://github.com/sg777/bet.git
	cd bet
	git checkout rest_dev
	echo "Building bet - will take 1 minute"
	make
else
	echo "Already tried installing"
	sleep 2
fi
}

function install_bet_poker {
if [ ! -d $HOME/bet ] ; then
	cd $HOME
	echo "Installing some dependencies - might ask for sudo password"
	sleep 3
	sudo apt-get install -y software-properties-common autoconf git build-essential libtool libprotobuf-c-dev libgmp-dev libsqlite3-dev python python3 zip jq libevent-dev pkg-config libssl-dev libcurl4-gnutls-dev cmake ninja-build libsqlite3-dev libgmp3-dev
	echo "Cloning nng"
	sleep 2
	cd $HOME
	git clone https://github.com/nanomsg/nng.git
	cd nng
	mkdir build
	cd build
	echo "Building nng"
	cmake -G Ninja ..
	ninja
	ninja test
	sudo ninja install
	echo "Cloning sg777's bet repo from https://github.com/sg777/bet"
	sleep 2
	cd $HOME
	git clone https://github.com/sg777/bet.git
	cd bet
	git checkout poker
	echo "Building bet - will take 1 minute"
	make
else
	echo "Already tried installing"
	sleep 2
fi
}

function start_frontend {
cd $HOME/pangea-poker-frontend/client
python -m SimpleHTTPServer 7777 
}
