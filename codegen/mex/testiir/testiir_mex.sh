MATLAB="/Applications/MATLAB_R2013b.app"
Arch=maci64
ENTRYPOINT=mexFunction
MAPFILE=$ENTRYPOINT'.map'
PREFDIR="/Users/Johan/.matlab/R2013b"
OPTSFILE_NAME="./mexopts.sh"
. $OPTSFILE_NAME
COMPILER=$CC
. $OPTSFILE_NAME
echo "# Make settings for testiir" > testiir_mex.mki
echo "CC=$CC" >> testiir_mex.mki
echo "CFLAGS=$CFLAGS" >> testiir_mex.mki
echo "CLIBS=$CLIBS" >> testiir_mex.mki
echo "COPTIMFLAGS=$COPTIMFLAGS" >> testiir_mex.mki
echo "CDEBUGFLAGS=$CDEBUGFLAGS" >> testiir_mex.mki
echo "CXX=$CXX" >> testiir_mex.mki
echo "CXXFLAGS=$CXXFLAGS" >> testiir_mex.mki
echo "CXXLIBS=$CXXLIBS" >> testiir_mex.mki
echo "CXXOPTIMFLAGS=$CXXOPTIMFLAGS" >> testiir_mex.mki
echo "CXXDEBUGFLAGS=$CXXDEBUGFLAGS" >> testiir_mex.mki
echo "LD=$LD" >> testiir_mex.mki
echo "LDFLAGS=$LDFLAGS" >> testiir_mex.mki
echo "LDOPTIMFLAGS=$LDOPTIMFLAGS" >> testiir_mex.mki
echo "LDDEBUGFLAGS=$LDDEBUGFLAGS" >> testiir_mex.mki
echo "Arch=$Arch" >> testiir_mex.mki
echo OMPFLAGS= >> testiir_mex.mki
echo OMPLINKFLAGS= >> testiir_mex.mki
echo "EMC_COMPILER=" >> testiir_mex.mki
echo "EMC_CONFIG=optim" >> testiir_mex.mki
"/Applications/MATLAB_R2013b.app/bin/maci64/gmake" -B -f testiir_mex.mk
