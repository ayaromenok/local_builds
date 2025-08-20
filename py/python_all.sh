VERSION=3.13
MINOR=.7
BETA=
WGET_PATH=https://www.python.org/ftp/python/$VERSION$MINOR/Python-$VERSION$MINOR$BETA.tar.xz
DIR_BUILD=~/sdk/src
DIR_VENV=~/sdk/venv

START=`date +%s`

mkdir -p $DIR_BUILD/python
cd $DIR_BUILD/python

wget $WGET_PATH
tar -xvf Python-$VERSION$MINOR$BETA.tar.xz

cd Python-$VERSION$MINOR$BETA
./configure --enable-optimizations

make -j$(nproc)
sudo make altinstall

cd ..
sudo rm -r Python-$VERSION$MINOR$BETA
rm Python-$VERSION$MINOR$BETA.tar.xz
wget https://bootstrap.pypa.io/get-pip.py
/usr/local/bin/python$VERSION ./get-pip.py
pip$VERSION --version
pip$VERSION install --upgrade pip
pip$VERSION install virtualenv

cd ..
rm -r $DIR_BUILD/python

mkdir -p $DIR_VENV
cd $DIR_VENV
python$VERSION -m virtualenv py$VERSION

END=`date +%s`
RUNTIME=$((END-START))

echo "Python $VERSION instaled in $RUNTIME seconds"