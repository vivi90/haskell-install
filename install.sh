#!/bin/bash
#
# Simple Haskell install script
#
# Tested on Manjaro Linux.
#
# Created: 2020 by Vivien Richter <vivien-richter@outlook.de>
# License: CC-BY-4.0
# Version: 1.0.0

# Installs GHC
sudo pacman -S ghc ghc-libs ghc-static

# Installs GHCUP
sudo wget https://gitlab.haskell.org/haskell/ghcup/raw/master//ghcup -O /usr/bin/ghcup
sudo chmod +x /usr/bin/ghcup
echo "export PATH=\$PATH:/home/$USER/.ghcup/bin" >> ~/.profile
export PATH=$PATH:/home/$USER/.ghcup/bin
ghcup upgrade

# Installs Cabal
ghcup install-cabal 3.2.0.0
echo "export PATH=\$PATH:/home/$USER/.cabal/bin" >> ~/.profile
export PATH=$PATH:/home/$USER/.cabal/bin
cabal update

# Installs Leancheck
cabal install --lib leancheck

# Installs Cyp
git clone https://gitlab.imn.htwk-leipzig.de/waldmann/cyp/
cd cyp
cabal install --allow-newer

# Tests Cyp
cyp -m test-data/pos-mod/by-rewriting.cyp

# Cleanup
cd ..
rm -Rf cyp

# Done
exit 0
