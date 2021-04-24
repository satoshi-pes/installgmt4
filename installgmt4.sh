#!/bin/bash

now=`pwd`

# install path
GMTPATH=$HOME/gmt4

# required libs
sudo apt install libxaw7-dev
sudo apt install libxt-dev
sudo apt install libnetcdf-dev

# create temporary directory
TMPDIR=`mktemp -d gmt-XXX`

# get gmt4 packages
curl -u anonymous:password ftp://ftp.soest.hawaii.edu/gmt/gmt-4.5.18-src.tar.bz2  -o $TMPDIR/gmt-4.5.18-src.tar.bz2
curl -u anonymous:password ftp://ftp.soest.hawaii.edu/gmt/gmt-4.5.18-non-gpl-src.tar.bz2  -o $TMPDIR/gmt-4.5.18-non-gps-src.tar.bz2
curl -u anonymous:password ftp://ftp.soest.hawaii.edu/gmt/gshhg-gmt-2.3.7.tar.gz  -o $TMPDIR/gshhg-gmt-2.3.7.tar.gz

# extract packages
tar xvfj $TMPDIR/gmt-4.5.18-src.tar.bz2   -C $TMPDIR
tar xvfj $TMPDIR/gmt-4.5.18-non-gps-src.tar.bz2   -C $TMPDIR
mkdir -p $GMTPATH/share/gmt
tar xvfz ./gshhg-gmt-2.3.7.tar.gz  -C $HOME/gmt4/share/gmt

# make 
cd $TMPDIR/gmt-4.5.18
./configure --prefix=$GMTPATH --with-gshhg-dir=$GMTPATH/share/gmt/gshhg --disable-flock --enable-triangle
make

make install-gmt
make install-data
make install-man
make install-doc

cd $now
rm -R $TMPDIR

# log
echo "##########################################"
echo " GMT4 install finished                    "
echo "##########################################"
echo "Add following PATHs to your .bashrc:"
echo "export PATH=\$PATH:$GMTPATH/bin"
echo "export MANPATH=\$MANPATH:$GMTPATH/man"
