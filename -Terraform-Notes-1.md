## 1.terraform.init
```
Initializing Working Directories

1. directory下 要提前至少有一个tf文件（这个叫configuration file）才可以init

2. init运行时候，会更新原provider requirements, module sources or version constraints, and backend configurations.（ 也就是.terraform的系统内容）

3.  如果不确定该不该run 这个命令, always safe to run multiple times


```
============================================================
## 2. terraform get
```
The terraform get command is used to download and update modules mentioned in the root module.

terraform get -update 

-update （只更新，不下载）- If specified, modules that are already downloaded will be checked for updates and the updates will be downloaded if present.

-只会init modules的部分，其他部分不init， 所以init可以代替 get。
```
============================================================
## 3.完成init的working directory一般有：

```
1. tf files 用来配置 resources

2. 隐藏目录.terraform 存储modules，plug-ins，workspaces的切换，和backend configuration .terraform 自己管理

3.tfstate文件，或者 tfstate.d 文件 用来管理local backend的状态文件


```
============================================================
## 4. Variables.tf
```
```
============================================================
## 5. Ouput.tf
```
```
============================================================
## 6. modules
```
```
============================================================
## 7.  .tfstate
```
```
============================================================
## 8. depends_on[ ]
```
```
============================================================
## 9. 同一类型的 a resource of a given type ("aws_instance") with a given local name ("web"). 
```
resource "aws_instance" "web1" {

}

resource "aws_instance" "web2" {

}
同一类型的resources 不能用 相同的local name

但是 不同类型的resources 可以用相同的local name

resource "aws_instance_xxx" "web1" {
   ////
}

引用时，通过 aws_instance_xxx.web1.attributes来引用

```
============================================================
## 1.
```
```
============================================================
## 1.
```
```
============================================================
## 1.
```
```
============================================================
## 1.
```
```
============================================================
## 1.
```
```
============================================================
## 1.
```
```
============================================================
## 1.
```
```
============================================================