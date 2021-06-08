# 交叉编译openJDK

## 0.准备工作




```text
sudo apt install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev  gawk build-essential bison flex texinfo gperf libtool patchutils bc   zlib1g-dev libexpat-dev git      libglib2.0-dev libfdt-dev libpixman-1-dev   libncurses5-dev libncursesw5-dev ninja-build   python3 autopoint pkg-config zip unzip screen   make libxext-dev libxrender-dev libxtst-dev     libxt-dev libcups2-dev libfreetype6-dev   mercurial libasound2-dev cmake libfontconfig1-dev git vim gettext rysnc wget 

Reading package lists... Done
Building dependency tree
Reading state information... Done
Note, selecting 'libexpat1-dev' instead of 'libexpat-dev'
E: Unable to locate package rysnc
```



按照上述的提示，将 'libexpat-dev'替换为 'libexpat1-dev' ；rysnc错了，应该是rsync ；更正后执行：

```
sudo apt install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev  gawk build-essential bison flex texinfo gperf libtool patchutils bc   zlib1g-dev libexpat1-dev git      libglib2.0-dev libfdt-dev libpixman-1-dev   libncurses5-dev libncursesw5-dev ninja-build   python3 autopoint pkg-config zip unzip screen   make libxext-dev libxrender-dev libxtst-dev     libxt-dev libcups2-dev libfreetype6-dev   mercurial libasound2-dev cmake libfontconfig1-dev git vim gettext wget rsync 
```





1、 下载工具链

```
git clone https://github.com/riscv/riscv-gnu-toolchain
```



2、更新qemu代码；

由于riscv-gnu-toolchain中已经包含了相关的软件包。我这里省去了第一步，直接更新代码。

```
git remote -v  
git branch -vv  #
git branch # 查看本地分支
git pull origin master
```



3、更新riscv-gnu-toolchain/riscv-glibc 为alistair/rv32.next分支代码

 git checkout -b alistair/rv32.next  origin/alistair/rv32.next

 remotes/origin/alistair/rv32.next

```
xj@e2ba8bd04169:~/RISCV/riscv-gnu-toolchain/riscv-glibc$  git checkout -b alistair/rv32.next  origin/alistair/rv32.next
Updating files: 100% (12690/12690), done.
Previous HEAD position was b190bccc8a configure: Replaced obsolete AC_TRY_COMPILE
Branch 'alistair/rv32.next' set up to track remote branch 'alistair/rv32.next' from 'origin'.
Switched to a new branch 'alistair/rv32.next'
xj@e2ba8bd04169:~/RISCV/riscv-gnu-toolchain/riscv-glibc$ git branch
* alistair/rv32.next
  master
xj@e2ba8bd04169:~/RISCV/riscv-gnu-toolchain/riscv-glibc$
```



4、更换linux-header

由于glibc2.32需要5.4版本以上的kernel headers支持，所以我们需要自己下载kernel源码并进行编译。

下载kernel源码并切换到v5.4版本：

```text
$ git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
$ cd linux
$ git checkout v5.4
$ make headers_install ARCH=riscv
```



--with-sysroot用来指定系统的root。该选项主要用于新系统（比如LFS）构建或交叉编译。比如你的LFS的root在/mnt/lfs，那么configure时指定--with-sysroot=/mnt/lfs，编译器就会使用/mnt/lfs上的header和lib，而不是host上的。交叉编译器也会设定sysroot，避免搜索默认的header和lib路径。可以写个最小程序然后gcc -v main.c，如果编译器的sysroot非默认，就会打印出sysroot路径。

prefix用来指定make install的安装目录。比如你不想把软件安装在/（/bin和/lib）或/usr（/usr/bin和/usr/lib），而是想安装到/usr/local（/usr/local/bin和/usr/local/lib），就可以指定--prefix=/usr/local。