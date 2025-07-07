#!/bin/bash
LIMIT_HANDLE_NUM=256 # size of block_size_in_oops, see jniHandles.hpp
for ((i=0; i<$LIMIT_HANDLE_NUM;i++)); do
    offset=$(($i*8))
    echo "offset: $offset"
    # run test command here
    ./build/linux-aarch64-normal-server-release/images/j2sdk-image/bin/java -XX:-TieredCompilation -XX:CICompilerCount=1 -XX:JNIHandleBlockAllocOffset=$offset Test2

    if [ $? -ne 134 ]; then
        echo "Test pased at iter: $i"
    else
        echo "Test stopped at iter: $i, allocate offset: $offset"
        exit1
    fi
done
