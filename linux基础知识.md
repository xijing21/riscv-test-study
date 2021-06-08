# linux基础知识

## apt

### [update与upgrade的区别](https://blog.csdn.net/qq_19004627/article/details/79560818)

在windows下安装软件，我们只需要有EXE文件，然后双击，下一步直接OK就可以了。但在LINUX下，不是这样的。每个LINUX的发行版，比如UBUNTU，都会维护一个自己的软件仓库，我们常用的几乎所有软件都在这里面。这里面的软件绝对安全，而且绝对的能正常安装。
那我们要怎么安装呢？在UBUNTU下，我们维护一个源列表，源列表里面都是一些网址信息，这每一条网址就是一个源，这个地址指向的数据标识着这台源服务器上有哪些软件可以安装使用。
编辑源命令：
```sudo gedit /etc/apt/sources.list```
在这个文件里加入或者注释（加#）掉一些源后，保存。这时候，我们的源列表里指向的软件就会增加或减少一部分。
接一下要做的就是：

```sudo apt-get update```
这个命令，会访问源列表里的每个网址，并读取软件列表，然后保存在本地电脑。我们在新立得软件包管理器里看到的软件列表，都是通过update命令更新的。

update后，可能需要upgrade一下。

```sudo apt-get upgrade```
这个命令，会把本地已安装的软件，与刚下载的软件列表里对应软件进行对比，如果发现已安装的软件版本太低，就会提示你更新。如果你的软件都是最新版本，会提示：
```升级了 0 个软件包，新安装了 0 个软件包，要卸载 0 个软件包，有 0 个软件包未被升级。```

**总而言之，update是更新软件列表，upgrade是更新软件。**



### 卸载软件

[apt-get卸载软件包](https://www.huaweicloud.com/articles/43312387a1964011b19cac2369e2f1ce.html)





## 环境变量

设置环境变量：非root用户下

【重要】https://blog.csdn.net/qq_19734597/article/details/103905155

修改/etc/profile 会出现失效的问题，就是刚设置并echo输出正确的环境变量，过会就无效了。

```
# 配置环境变量
xj@e2ba8bd04169:~$ vim ~/.bashrc
----在文件开头加入以下两行-------------
export RISCV=~/RISCV
export PATH=$RISCV/newlib/bin/:$PATH

# 使得环境变量生效
xj@e2ba8bd04169:~$ source ~/.bashrc

# 检查是否生效
xj@e2ba8bd04169:~$ echo $PATH
/home/xijing/RISCV/newlib/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
xj@e2ba8bd04169:~$ echo $RISCV
/home/xijing/RISCV
```

ps：修改~/.bashrc；而不是/etc/profile（环境变量会丢失）;



环境变量设置的方法很多，可参考：

[Ubuntu设置和查看环境变量](https://blog.csdn.net/White_Idiot/article/details/78253004)

[Ubuntu设置系统环境变量](https://www.jianshu.com/p/12fbfa8c7489)

[ubuntu环境变量的三种设置方法](https://www.cnblogs.com/jpfss/p/11107080.html)





## 权限管理

https://zhuanlan.zhihu.com/p/37964411

常用的命令有：

```
# 修改文件、文件夹所属用户
chown -R xijing RISCV

# 修改文件、文件夹所属组
chgrp -R xijing RISCV

# 修改权限
chmod -R 755 RISCV
```



统计文件夹大小： du -sh 文件夹路径

查找指定文件：find [searchpath] -name   [filename]

在vim中查询：输入：/要查找的字符





## python  & pip

[python与pip版本对应关系](https://blog.csdn.net/weixin_48776804/article/details/113780133)

[pip与pip3的区别和联系](https://blog.csdn.net/dianwonin4433/article/details/101868849)

python 有python2和python3的区别（Ubuntu的系统会默认装有python2和python3）
那么pip也有pip和pip3的区别
大概是这样的
pip是python的包管理工具，pip和pip3版本不同，都位于Scripts\目录下：
如果系统中只安装了Python2，那么就只能使用pip。
如果系统中只安装了Python3，那么既可以使用pip也可以使用pip3，二者是等价的。
如果系统中同时安装了Python2和Python3，则pip默认给Python2用，pip3指定给Python3用。





$ sudo apt-get install python-pip
Reading package lists... Done
Building dependency tree
Reading state information... Done
Package python-pip is not available, but is referred to by another package.
This may mean that the package is missing, has been obsoleted, or
is only available from another source
However the following packages replace it:
  python3-pip

E: Package 'python-pip' has no installation candidate