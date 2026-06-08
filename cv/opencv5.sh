VERSION=5.$1
MINOR=.$2
if [ -z "$1" ]; then
    echo "missing Version"
    VERSION=5.0
fi
if [ -z "$2" ]; then
    echo "missing Minor Version"
    MINOR=.0
fi
echo "OpenCV version  $VERSION$MINOR"

GIT_PATH=https://github.com/opencv/opencv.git
DIR_SRC=~/sdk/src
DIR_BUILD=~/sdk/build

TIMER_START=`date +%s`

mkdir -p $DIR_SRC/opencv
cd $DIR_SRC/opencv
git clone $GIT_PATH
cd opencv
git checkout $VERSION$MINOR

mkdir -p $DIR_BUILD/opencv
cd $DIR_BUILD/opencv

cmake ../../src/opencv/opencv

make -j$(nproc)
sudo make install

TIMER_END=`date +%s`
RUNTIME=$((TIMER_END-TIMER_START))

sudo ldconfig
echo "OpenCV $VERSION instaled in $RUNTIME seconds"