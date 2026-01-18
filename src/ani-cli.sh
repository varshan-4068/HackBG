#!/usr/bin/env bash

anime() {

	ani_dir=/usr/local/bin
	echo
	echo "[+] Setting Up ani-cli"
	echo
	git clone https://github.com/pystardust/ani-cli.git
	echo 
	sudo cp -r ani-cli/ani-cli $ani_dir
	sudo rm -rf ani-cli
	echo
	return
}

anime
