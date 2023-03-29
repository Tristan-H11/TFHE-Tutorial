export C_INCLUDE_PATH=/usr/local/include
export CPLUS_INCLUDE_PATH=/usr/local/include
export LIBRARY_PATH=/usr/local/lib
export LD_LIBRARY_PATH=/usr/local/lib

# Remove old build-results
./clean-builds.sh

# Build Alice
cd Alice || { echo "Dir 'Alice' not found"; exit 1; }
gcc alice.c -o alice -l tfhe-nayuki-portable
./alice

# Copy cloud-relevant files
cd ..
cp Alice/cloud.key Cloud/
cp Alice/cloud.data Cloud/

# Build Cloud
cd Cloud || { echo "Dir 'Cloud' not found"; exit 1; }
gcc cloud.c -o cloud -l tfhe-nayuki-portable
./cloud

# Copy verify-relevant files
cd ..
cp Alice/secret.key Verify/
cp Cloud/answer.data Verify/

# Build Verify
cd Verify || { echo "Dir 'Verify' not found"; exit 1; }
gcc verify.c -o verify -l tfhe-nayuki-portable
./verify