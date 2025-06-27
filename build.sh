#/bin/sh
# Build script for Tuxedo drivers
# Builts: tuxedo-drivers-kmod-common, kmod-tuxedo-drivers (for your kernel) and akmod-tuxedo-drivers

set -e

if [ ! -d ~/rpmbuild/SPECS ] ; then
  mkdir -p ~/rpmbuild/SPECS
fi

for prg in spectool rpmbuild kmodtool ; do
  which $prg 2>/dev/null || echo "Install $prg to create the build files"
done

echo "--> Copying spec files to ~/rpmbuild/SPECS/"
cp ./tuxedo-drivers-kmod.spec ~/rpmbuild/SPECS/
cp ./tuxedo-drivers-kmod-common.spec ~/rpmbuild/SPECS/

cd ~/rpmbuild/SPECS/

echo "--> Installing dependencies"
spectool -g -R tuxedo-drivers-kmod.spec

# rm ~/rpmbuild/RPMS/x86_64/* -f

echo "--> Building RPMs"
rpmbuild -ba tuxedo-drivers-kmod-common.spec
rpmbuild -ba tuxedo-drivers-kmod.spec
rpmbuild -ba tuxedo-drivers-kmod.spec --define 'kernels $(uname -r)'

echo "--> Listing RPMs"
tree ~/rpmbuild/RPMS/
