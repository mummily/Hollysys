rm -rf /lib64/libstdc++.so.6
ln -s /usr/local/gcc-9.3.0/lib64/libstdc++.so.6.0.28 /lib64/libstdc++.so.6
cmake -DCMAKE_C_COMPILER=/usr/local/gcc/bin/gcc -DCMAKE_CXX_COMPILER=/usr/local/gcc/bin/g++ -DCMAKE_BUILD_TYPE=Debug .
cmake --build . --config Debug
