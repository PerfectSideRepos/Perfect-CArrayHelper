# Perfect CArray [简体中文](README.zh_CN.md)

<p align="center">
    <a href="http://perfect.org/get-involved.html" target="_blank">
        <img src="http://perfect.org/assets/github/perfect_github_2_0_0.jpg" alt="Get Involed with Perfect!" width="854" />
    </a>
</p>

<p align="center">
    <a href="https://github.com/PerfectlySoft/Perfect" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_1_Star.jpg" alt="Star Perfect On Github" />
    </a>  
    <a href="http://stackoverflow.com/questions/tagged/perfect" target="_blank">
        <img src="http://www.perfect.org/github/perfect_gh_button_2_SO.jpg" alt="Stack Overflow" />
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
    <a href="http://perfect.ly" target="_blank">
        <img src="http://perfect.ly/badge.svg" alt="Slack Status">
    </a>
</p>


CArray is a generic class for Null-Terminated array manager with an auto release pool to help end users interact with traditional C APIs easily.

This package builds with Swift Package Manager and is part of the [Perfect](https://github.com/PerfectlySoft/Perfect) project. Files in this repository, however, is an independent module which can be used without specific conditions.

## Demo

``` swift
import PerfectCArray

// initialize a string manager
let helper = CArray<UnsafeMutablePointer<Int8>>()

// initialize a string array pointer
var array = UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>(bitPattern: 0)

// append some strings to the array
let _  = helper.append(pArray: &array, element: strdup("hello"))
let _  = helper.append(pArray: &array, element: strdup("world!"))

// iterate pointers in the array, and release the strdup
helper.forEach(array: array!) { str in
  let s = String(cString: str)
  print(s)
  free(str)
}//next

// do some more array stuff with this pointer
let total = helper.withArray(of: array!) { a -> Int in
  // how many elements, including the null terminator, in the pointer?
  return a.count
}//end total
print(total)
```
## Quick Start

### Swift Package Manager

Add a dependency to Package.swift:

``` swift
.Package(url: "https://github.com/PerfectSideRepos/Perfect-CArrayHelper.git", majorVersion:1)
```

### Header Declaration

Import Perfect-CArray to your source code:

``` swift
import PerfectCArray
```

### Initialization

To manage all C fashioned arrays, e.g., a Null-Terminated string array, initialize a helper like this:

``` swift
// initialize a string manager
let helper = CArray<UnsafeMutablePointer<Int8>>()
```

### Append Elements

To append a new element, e.g, a string, to the end of the array pointer, especially from an empty array, please check the snippet below:

``` swift
// initialize a string array pointer
var array = UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>(bitPattern: 0)

// append some strings to the array
let b = helper.append(pArray: &array, element: strdup("hello"))
if b {
  // the element has already been appended to the array
}else{
  // something goes wrong here
}
```

### Iteration

To iterate all element in a null terminated array pointer, try the snippet below:

``` swift
helper.forEach(array: array!) { element in
  // check every element here
}//next
```

### As An Swift Array

Moreover, CArray can also help you deal with the sticky C array pointer in a Swift array fashion, such as get index, set / get, and count the elements:

``` swift
// do some more array stuff with this pointer
let total = helper.withArray(of: array!) { a -> Int in
  // how many elements, including the null terminator, in the pointer?
  return a.count
}//end total
print(total)
```

## Issues

We are transitioning to using JIRA for all bugs and support related issues, therefore the GitHub issues has been disabled.

If you find a mistake, bug, or any other helpful suggestion you'd like to make on the docs please head over to [http://jira.perfect.org:8080/servicedesk/customer/portal/1](http://jira.perfect.org:8080/servicedesk/customer/portal/1) and raise it.

A comprehensive list of open issues can be found at [http://jira.perfect.org:8080/projects/ISS/issues](http://jira.perfect.org:8080/projects/ISS/issues)

## Further Information
For more information on the Perfect project, please visit [perfect.org](http://perfect.org).
