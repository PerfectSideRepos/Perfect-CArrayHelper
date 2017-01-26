# Perfect OpenLDAP C 语言函数库 [English](README.md)

<p align="center">
    <a href="http://perfect.org/get-involved.html" target="_blank">
        <img src="http://perfect.org/assets/github/perfect_github_2_0_0.jpg" alt="Get Involed with Perfect!" width="854" />
    </a>
</p>

<p align="center">
    <a href="https://github.com/PerfectlySoft/Perfect" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_1_Star.jpg" alt="Star Perfect On Github" />
    </a>  
    <a href="https://gitter.im/PerfectlySoft/Perfect" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_2_Git.jpg" alt="Chat on Gitter" />
    </a>  
    <a href="https://twitter.com/perfectlysoft" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_3_twit.jpg" alt="Follow Perfect on Twitter" />
    </a>  
    <a href="http://perfect.ly" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_4_slack.jpg" alt="Join the Perfect Slack" />
    </a>
</p>

<p align="center">
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat" alt="Swift 3.0">
    </a>
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Platforms-OS%20X%20%7C%20Linux%20-lightgray.svg?style=flat" alt="Platforms OS X | Linux">
    </a>
    <a href="http://perfect.org/licensing.html" target="_blank">
        <img src="https://img.shields.io/badge/License-Apache-lightgrey.svg?style=flat" alt="License Apache">
    </a>
    <a href="http://twitter.com/PerfectlySoft" target="_blank">
        <img src="https://img.shields.io/badge/Twitter-@PerfectlySoft-blue.svg?style=flat" alt="PerfectlySoft Twitter">
    </a>
    <a href="https://gitter.im/PerfectlySoft/Perfect?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge" target="_blank">
        <img src="https://img.shields.io/badge/Gitter-Join%20Chat-brightgreen.svg" alt="Join the chat at https://gitter.im/PerfectlySoft/Perfect">
    </a>
    <a href="http://perfect.ly" target="_blank">
        <img src="http://perfect.ly/badge.svg" alt="Slack Status">
    </a>
</p>



CArray 是一个线程安全的 C 语言数组指针管理器，内建指针释放机制，特别适用于以空指针结尾的C语言风格数组管理。

本项目通过SPM进行编译，是[Perfect](https://github.com/PerfectlySoft/Perfect) 项目的一个组成部分，不需要手工修改或下载。

## 示范程序

``` swift
import PerfectCArray

// 初始化一个字符串数组类型的指针管理器
let helper = CArray<UnsafeMutablePointer<Int8>>()

// 初始化一个字符串数组指针
var array = UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>(bitPattern: 0)

// 增加一个元素
let _  = helper.append(pArray: &array, element: strdup("hello"))
let _  = helper.append(pArray: &array, element: strdup("world!"))

// 针对一个数组指针遍历所有的元素
helper.forEach(array: array!) { str in
  let s = String(cString: str)
  print(s)
}//next

// 用 Swift 数组的方式来使用指针：
let total = helper.withArray(of: array!) { a -> Int in
  // 比如统计一下有多少个元素（包括零元素指针在内）
  return a.count
}//end total
print(total)
```
## 快速上手

### SPM软件包管理器

请在您的 Package.swift 文件中增加如下依存关系:

``` swift
.Package(url: "https://github.com/PerfectSideRepos/Perfect-CArrayHelper.git", majorVersion:1)
```

### 导入函数库

请将 Perfect-CArray 导入目标源代码

``` swift
import PerfectCArray
```

### 初始化

为了方便管理某一类指针，特别是C语言风格的以空指针结尾的指针数组，请参考下列代码进行管理器初始化：

``` swift
// 初始化一个指针数组管理器
let helper = CArray<UnsafeMutablePointer<Int8>>()
```

### 增加元素

如果需要在数组指针尾部增加元素，特别是自动初始化一个数组，请参考下列代码：

``` swift
// 首先声明一个空指针
var array = UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>(bitPattern: 0)

// 然后将新元素增加到指针数组尾部
let b = helper.append(pArray: &array, element: strdup("hello"))
if b {
  // 追加成功
}else{
  // 操作失败
}
```

### 遍历

下列代码展示了如何遍历一个数组指针：

``` Swift
helper.forEach(array: array!) { element in
  // 查看每一个元素
}//next
```

### 像使用 Swift 数组一样使用指针

此外，CArray 更强大的能力在于能够提供一个 Swift 数组，用于管理指针内的元素：

``` swift
// 用 Swift 数组的方式来使用指针：
let total = helper.withArray(of: array!) { a -> Int in
  // 比如统计一下有多少个元素（包括零元素指针在内）
  return a.count
}//end total
print(total)
```

### 问题报告、内容贡献和客户支持

我们目前正在过渡到使用JIRA来处理所有源代码资源合并申请、修复漏洞以及其它有关问题。因此，GitHub 的“issues”问题报告功能已经被禁用了。

如果您发现了问题，或者希望为改进本文提供意见和建议，[请在这里指出](http://jira.perfect.org:8080/servicedesk/customer/portal/1).

在您开始之前，请参阅[目前待解决的问题清单](http://jira.perfect.org:8080/projects/ISS/issues).

## 更多信息
关于本项目更多内容，请参考[perfect.org](http://perfect.org).
