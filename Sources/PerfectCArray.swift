//
//  PerfectCArray.swift
//  Perfect-CArray
//
//  Created by Rocky Wei on 2017-01-26.
//	Copyright (C) 2017 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2017 - 2018 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

/// CArray - A generic class for C fashioned null terminated array pointers
/// Features: auto release, thread safe
public class CArray<T> {

  /// auto release pool, with [T?] as element and the base address of [T?] as its key
  internal var pool: [UnsafeMutablePointer<T?>: Any] = [:]

  /// not sure if necessary, but release them for safe
  deinit {
    for (_ , v) in pool {
      var array = v as? [T?] ?? []
      array.removeAll()
    }//next
  }//deinit

  /// append an element to the end of null - terminated array pointer
  /// - parameters:
  ///   - pArray: mutable pointer of an array pointer. Will be automatically allocated after calling if nil.
  ///   - element: element to add
  /// - returns:
  ///   true for success and false only if the array pointer was not allocated / managed by current CArray instance
  public func append(pArray: UnsafeMutablePointer<UnsafeMutablePointer<T?>?>, element: T) -> Bool {

    // if the array is null
    guard let array = pArray.pointee else {

      // allocate a new one
      var sArray:[T?] = [element, nil]

      // get the pointer of array
      let array = sArray.withUnsafeMutableBufferPointer { $0.baseAddress }

      // deposit the array to the management pool
      pool[array!] = sArray

      // return the new allocated pointer
      pArray.pointee = array

      return true
    }//end guard

    // otherwise get the array from pool
    var sArray = pool[array] as? [T?] ?? []

    // if failed to get, it means that this pointer was not allocated by current CArray instance
    if sArray.isEmpty {

      // return false to indicate failure
      return false
    }//end if

    // append the element to the end of array
    sArray[sArray.count - 1] = element

    // append a null terminator
    sArray.append(nil)

    // remove the old address
    pool.remove(at: pool.index(forKey: array)!)

    // get the new address
    let newArray = sArray.withUnsafeMutableBufferPointer { $0.baseAddress }

    // deposit the new address to the management pool
    pool[newArray!] = sArray

    // return the reallocated array
    pArray.pointee = newArray
    return true
  }//end append

  /// safely iterate the elements in an pointer array
  /// - parameters:
  ///   - array: the array to iterate
  ///   - body: closure for iterating
  public func forEach(array: UnsafeMutablePointer<T?>, _ body: (T) throws -> Void) rethrows {

    // load the pointer
    let sArray = pool[array] as? [T?] ?? []

    // loop until a null terminator appears.
    for element in sArray {
      guard let e = element else {
        break
      }// guard
      try body(e)
    }//next
  }//end forEach

  /// a more generic to help users operate the pointer in an array fashion.
  /// - parameters:
  ///   - of: the objective array pointer
  ///   - body: closure for array operations, with a return value
  /// - returns:
  ///   return the body returns
  public func withArray<R>(of: UnsafeMutablePointer<T?>, _ body: ([T?]) throws -> R) rethrows -> R {
    // load the pointer
    var sArray = pool[of] as? [T?] ?? []

    // call the array
    let r = try body(sArray)

    // remove the old address
    pool.remove(at: pool.index(forKey: of)!)

    // get the new address
    let newArray = sArray.withUnsafeMutableBufferPointer { $0.baseAddress }

    // deposit the new address to the management pool
    pool[newArray!] = sArray

    return r
  }//end func
}//end class
