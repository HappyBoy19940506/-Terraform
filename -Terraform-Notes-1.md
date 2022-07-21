## 1.terraform.init
```
Initializing Working Directories

1. directory下 要提前至少有一个tf文件（这个叫configuration file）才可以init

2. init运行时候，会更新原provider requirements, module sources or version constraints, and backend configurations.（ 也就是.terraform的系统内容）特别是modules的变化，一定要init

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

3. tfstate文件，或者 tfstate.d 文件 用来管理local backend的状态文件


```
============================================================
## 4. backend
```
ssss

```
https://www.terraform.io/language/settings/backends/configuration
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
```.
```
https://www.devopsschool.com/blog/what-is-terraform-tfstate-backup-file-in-terraform/#:~:text=By%20default%2C%20a%20backup%20of,metadata%20information%20about%20your%20infrastructure.

============================================================
## 8. depends_on[resource.name] 或者[module.name]
```
 depends_on 一般用在 不能自动 infer的判断 归属关系的resource，
 比如 ：必须要有 iam role policy 才能创建
 
 resource "aws_iam_role" "example" {
  name = "example"

  # assume_role_policy is omitted for brevity in this example. Refer to the
  # documentation for aws_iam_role for a complete example.
  assume_role_policy = "..."
}

resource "aws_iam_instance_profile" "example" {
  # Because this expression refers to the role, Terraform can infer
  # automatically that the role must be created first.
  role = aws_iam_role.example.name
}

resource "aws_iam_role_policy" "example" {
  name   = "example"
  role   = aws_iam_role.example.name
  policy = jsonencode({
    "Statement" = [{
      # This policy allows software running on the EC2 instance to
      # access the S3 API.
      "Action" = "s3:*",
      "Effect" = "Allow",
    }],
  })
}

resource "aws_instance" "example" {
  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"

  # Terraform can infer from this that the instance profile must
  # be created before the EC2 instance.
  iam_instance_profile = aws_iam_instance_profile.example

  # However, if software running in this EC2 instance needs access
  # to the S3 API in order to boot properly, there is also a "hidden"
  # dependency on the aws_iam_role_policy that Terraform cannot
  # automatically infer, so it must be declared explicitly:
  depends_on = [
    aws_iam_role_policy.example
  ]
}

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
## 10. IAM 
```
```
============================================================
## 11. acl 与 s3 policy bucket的关系
```
1. acl推荐 关闭， 用 bucket owner enforced
2. 如果没关， objec要设 --acl  public-read等属性

```
https://docs.aws.amazon.com/AmazonS3/latest/userguide/ensure-object-ownership.html#object-ownership-requiring-bucket-owner-enforced
https://docs.aws.amazon.com/AmazonS3/latest/userguide/acl-overview.html#specifying-grantee
https://aws.amazon.com/about-aws/whats-new/2021/11/amazon-s3-object-ownership-simplify-access-management-data-s3/
============================================================
## 12. jenkinsfile如何format？
```
变成js 再用 右键， format document

```
https://stackoverflow.com/questions/56151004/vscode-and-jenkinsfiles-how-do-i-format-them
============================================================
## 13. 双引号 单引号 一些思辨
```
echo " wo shi ${NAME} " 
echo要用双引号 ,如果用单引号就报错了
sh 'mkdir ${NAME}'   ---  是“mkdir ${NAME}"
sh 既可以单引号 也可以 双引号哦
```
============================================================
## 14.关于 dockerfile和 原生image的一点思辨
```
1. dockefile - 里面自带一些原生raw+一些自己的文件 组成的 可以生成image的文件
2. dockefile = 自己的东西+image
3. dockerfile通过docker build生成了一个 自己独特的image， 所以这个image =dockerfile所代表的东西，可以用来作为模版生成很多很多 container中的程序。

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
