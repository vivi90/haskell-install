#!/bin/bash
#
# Simple Haskell install script
#
# Tested on Manjaro Linux.
#
# Created: 2021 by Vivien Richter <vivien-richter@outlook.de>
# License: CC-BY-4.0
# Version: 2.0.0

# Configuration
CYP_SOURCE="https://gitlab.imn.htwk-leipzig.de/waldmann/cyp"

# Installs GHC, libs and Cabal
echo -e '\033[1mInstalling GHC, libs and Cabal..\033[0m'
sudo pacman -S ghc ghc-libs ghc-static cabal-install
ghci --version
cabal --version
cabal update
echo "export PATH=\$PATH:/home/$USER/.cabal/bin" >> ~/.profile
export PATH=$PATH:/home/$USER/.cabal/bin

# Installs LeanCheck
read -e -n 1 -p $'\033[1mDo you want to install LeanCheck? [y/n]: \033[0m'
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cabal install --lib leancheck
fi

# Installs cyp
read -e -n 1 -p $'\033[1mDo you want to install cyp? [y/n]: \033[0m'
if [[ $REPLY =~ ^[Yy]$ ]]; then
    git clone "$CYP_SOURCE" cyp
    cd cyp
    cabal install --allow-newer
    cyp -m test-data/pos-mod/by-rewriting.cyp
    cd ..
    rm -Rf cyp
fi

# Done.
echo -e '\033[1mDone.\033[0m'
