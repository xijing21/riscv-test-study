想起章翔说的给的连接地址执行失败，使用llvm/llvm-project执行成功的例子了。

xj@e2ba8bd04169:~/RISCV/llvm-project0$ git remote -v
origin  https://github.com/llvm/llvm-project.git (fetch)
origin  https://github.com/llvm/llvm-project.git (push)
xj@e2ba8bd04169:~/RISCV/llvm-project0$   git pull



xj@e2ba8bd04169:~/RISCV/llvm-project0/build$ ./bin/llvm-lit --version
lit 13.0.0dev

将git的test-suite放到llvm-project/llvm/projects下面；然后同时在llvm-project/llvm/projects下面创建test-suite-build作为其构建路径；

llvm-project/llvm/projects/test-suite

xj@e2ba8bd04169:~/RISCV/llvm-project0/build$                   git clone https://github.com/llvm/llvm-test-suite.git test-suite
xj@e2ba8bd04169:~/RISCV/llvm-project0/llvm/projects $    mkdir test-suite-build && cd test-suite-build

xj@e2ba8bd04169:~/RISCV/llvm-project0/build/test-suite/build$ cmake -DCMAKE_C_COMPILER=/home/xj/RISCV/llvm-project0/build/bin/clang -C../test-suite/cmake/caches/O3.cmake ../test-suite

make



![image-20210603142331645](images/image-20210603142331645.png)



修改xj@e2ba8bd04169:~/RISCV/llvm-project0/llvm/projects/test-suite-build$ vim ../test-suite/MicroBenchmarks/CMakeLists.txt

注释掉add_subdirectory(XRay)







xj@e2ba8bd04169:~/RISCV/llvm-project0/llvm/projects/test-suite-build$ vim ../test-suite/MicroBenchmarks/CMakeLists.txt

```text
CMAKE_C_FLAGS:STRING = -fPIE
CMAKE_CXX_FLAGS:STRING = -fPIE
```

xj@e2ba8bd04169:~/RISCV/llvm-project0/llvm/projects/test-suite-build$ vim CMakeCache.txt
xj@e2ba8bd04169:~/RISCV/llvm-project0/llvm/projects/test-suite-build$ vim CMakeCache.txt
xj@e2ba8bd04169:~/RISCV/llvm-project0/llvm/projects/test-suite-build$ find ../ -name speedtest.tcl
../test-suite/MultiSource/Applications/sqlite3/speedtest.tcl
xj@e2ba8bd04169:~/RISCV/llvm-project0/llvm/projects/test-suite-build$ sudo chmod +x ../test-suite/MultiSource/Applications/sqlite3/speedtest.tcl
[sudo] password for xj:
xj@e2ba8bd04169:~/RISCV/llvm-project0/llvm/projects/test-suite-build$ ll ../test-suite/MultiSource/Applications/sqlite3/speedtest.tcl
-rwxrwxr-x 1 xj xj 4151 Jun  2 19:12 ../test-suite/MultiSource/Applications/sqlite3/speedtest.tcl*
xj@e2ba8bd04169:~/RISCV/llvm-project0/llvm/projects/test-suite-build$