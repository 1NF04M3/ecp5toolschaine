mkdir env_src 
pushd env_src
if [ ! -f boost_1_81_0_rc1.tar.gz ]
then
  wget https://boostorg.jfrog.io/artifactory/main/release/1.81.0/source/boost_1_81_0_rc1.tar.gz
fi

tar xzf boost_1_81_0_rc1.tar.gz
pushd boost_1_81_0
sh bootstrap.sh --prefix=../../devtools
/b2 install --prefix=../../devtools
popd

git clone https://github.com/YosysHQ/yosys.git
pushd yosys
make -j5 PREFIX=../../devtools/ install
rm -rf yosys
popd


git clone --recurse-submodules https://github.com/YosysHQ/prjtrellis.git
pushd prjtrellis/libtrellis
cmake -DCMAKE_INSTALL_PREFIX=../../devtools 
make -j3
make install
popd

git clone https://github.com/YosysHQ/nextpnr.git
pushd nextpnr
cmake . -DARCH=ecp5 -DTRELLIS_INSTALL_PREFIX=../../devtools
make -j5
make install
popd
