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

https://www.pkslow.com/archives/terraform-state#:~:text=State%20%E7%8A%B6%E6%80%81%E6%98%AFTerraform%E7%94%A8,%E7%8A%B6%E6%80%81%EF%BC%8C%E7%8E%B0%E6%9C%89%E7%9A%84%E6%A0%B7%E5%AD%90%E3%80%82
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
## 15. depends_on
```
```
https://www.terraform.io/language/meta-arguments/depends_on
============================================================
## 16. ACM-SSL certificate by Terrraform
```
depends_on Route53 moudle 
```
https://www.youtube.com/watch?v=S_KWZUexe4g
============================================================
## 17.Using Terraform to Create an S3 Website Bucket
```

```
https://faun.pub/using-terraform-to-create-an-s3-website-bucket-347eda50239c
============================================================
## 18 Docker tag  的用法
```

```
https://docs.docker.com/engine/reference/commandline/tag/
============================================================
## 19 S3（not public）-CLOUDFRONT-OAI (手动）
```
If you don’t use an OAI, the S3 bucket must allow public access.

OAI prevents users from viewing your S3 files by simply using the direct URL for the file, for example: 

https://app-private-bucket-stormit.s3.eu-central-1.amazonaws.com/pics/logo.png 


Your users can only use the URL of your CloudFront distribution, for example: https://d2whx7jax6hbi5.cloudfront.net/pics/logo.png

```
https://www.stormit.cloud/post/cloudfront-origin-access-identity
============================================================
## 20 website redirect- if s3 not public
```
不需要2个s3了，如果用cloudfront的话，意味着不需要两个s3来做redirect,你也做不了说实话，

One of the main reasons for using the S3 static website hosting function is that you can very simply use redirection rules. 

This will not work if you use the OAI function in CloudFront. 

特别注意：2个s3的方法在 cloudfront使用OAI-也就是s3并不是public access的时候不能使用。 确实，无法公共访问你还怎么redirect。
用#19中的方法。在 CNAME处，添加 多个 申请下证书的域名，就可以全部指向到 origin了。

Use Route 53 with an S3 website to redirect one domain to another domain through an HTTP redirect. 

Amazon S3 static web hosting supports only the HTTP protocol. You must use a CloudFront distribution for redirection from HTTP to HTTPS.

-造成的区别就是 并不能造成视觉效果上的跳转：你可以看到 A redirect to B
-cloudfront CNAME的方法 A的URL并不会发生变化。


```

============================================================
## 21 adding an SSL certificate is that your browser still shows your site as insecure
```
1.  your code contains some http url, not https url.
2.  你如果直接用s3 静态hosting，你拉出来的route53的那个url 就算有证书 也不是secure的，因为：
SSL certificates are not connected to a domain's DNS record (via Route 53).

Instead, they are connected to one or more specific infrastructure components.

SSL certificates that you create from ACM can be used with:

AWS Elastic Load Balancer
AWS CloudFront

Create your infrastructure including one or more of those components and then attach your ACM SSL certificate to that.

-也就是说 ssl证书使用在 cloudfornt上的，而不是给你route53的domain name的，所以 你要想一个域名获得 安全标志，

-你需要 ：在cloudfront的一个distribution上面的 alternative domain name绑定上该 域名，

-并且 --- 在 behavior 设置成： 
In AWS Cloudfront, click on your distribution, then click on "Behaviors"

Set behavior to "Redirect HTTP to HTTPS"

- s3 web hosting 那套只能用来 http的redirect

```

============================================================
## 22 cloudfront 和 s3 的思辨
```
1. cloudfront的存在 - 我不想用户有机会直接访问的s3的bucket的url，一定要通过cloudfront

2. 设置cloudfront的cname 并且给他证书，让他可以走https，默认的s3 静态网址hosting是不能走https protocol的，只支持http

3. cloudftont 缓存技术，让你临近get数据，更快，更安全
```

============================================================
## 1
```

```

============================================================## 1
```

```

============================================================
## 1
```

```

============================================================
## 1
```

```

============================================================
## 1
```

```

============================================================
## 1
```

```

============================================================
## 1
```

```

============================================================
## 1
```

```

============================================================
## 1
```

```

============================================================
## 1
```

```

============================================================
## 1
```

```

============================================================
## 1
```

```

============================================================
