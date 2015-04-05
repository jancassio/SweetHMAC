//
//  SweetHMACTests.swift
//  SweetHMACTests
//
//  Created by Jan Cássio on 1/7/15.
//  Copyright (c) 2015 Jan Cassio. All rights reserved.
//

import UIKit
import XCTest
import SweetHMAC


let quote = "I'm going to make him an offer he can't refuse"
let author = "Vito Corleone"
let expectedValues:[HMACAlgorithm:String] = [
  .MD5      :"e470f785afb708cd8c2a31860642fd11",
  .SHA1     :"708d7175e4f1e8b9d26f3b4f36222f7cef17cdc6",
  .SHA224   :"e85406784fd773f76b236df5614505b1027506750f75152bf06554d3",
  .SHA256   :"31f2f1fe65304c1960a5f49600a8c6f19d013b9ea42dc94407b26fc347b1ce42",
  .SHA384   :"234eeb30d96f5c09c501e9defa590f8f3a5e91455c84484639ded7f4f8b8b2c3714a803d42b503d10149a9422923a5e2",
  .SHA512   :"a978a70f3fa49880982f0e57d12d96066b281e590812a01af19aeab4db9637f0eaa7dbab3d975c4841f4b59e4879fc56bbedee6326fb598b8ffb1a914c8e0f46"
]

class SweetHMACTest: XCTestCase {
  
  func testMD5() {
    let algorithm:HMACAlgorithm = .MD5
    let hmac = SweetHMAC(message: quote, secret: author).HMAC(algorithm)
    XCTAssertEqual(hmac, expectedValues[algorithm]!, "Should be equal to expected value")
  }
  
  func testSHA1() {
    let algorithm:HMACAlgorithm = .SHA1
    let hmac:String = SweetHMAC(message: quote, secret: author).HMAC(algorithm)
    XCTAssertEqual(hmac, expectedValues[algorithm]!, "Should be equal to expected value")
  }
  
  func testSHA224() {
    let algorithm:HMACAlgorithm = .SHA224
    let hmac:String = SweetHMAC(message: quote, secret: author).HMAC(algorithm)
    XCTAssertEqual(hmac, expectedValues[algorithm]!, "Should be equal to expected value")
  }
  
  func testSHA256() {
    let algorithm:HMACAlgorithm = .SHA256
    let hmac:String = SweetHMAC(message: quote, secret: author).HMAC(algorithm)
    XCTAssertEqual(hmac, expectedValues[algorithm]!, "Should be equal to expected value")
  }
  
  func testSHA384() {
    let algorithm:HMACAlgorithm = .SHA384
    let hmac:String = SweetHMAC(message: quote, secret: author).HMAC(algorithm)
    XCTAssertEqual(hmac, expectedValues[algorithm]!, "Should be equal to expected value")
  }
  
  func testSHA512() {
    let algorithm:HMACAlgorithm = .SHA512
    let hmac:String = SweetHMAC(message: quote, secret: author).HMAC(algorithm)
    XCTAssertEqual(hmac, expectedValues[algorithm]!, "Should be equal to expected value")
  }
}

class SweetHMACStringExtensionTests: XCTestCase {
  
  func testMD5() {
    let algorithm:HMACAlgorithm = .MD5
    let hmac:String = quote.HMAC(algorithm, secret: author)
    XCTAssertEqual(hmac, expectedValues[.MD5]!, "Should be equal to expected value")
  }
  
  func testSHA1() {
    let algorithm:HMACAlgorithm = .SHA1
    let hmac:String = quote.HMAC(algorithm, secret: author)
    XCTAssertEqual(hmac, expectedValues[algorithm]!, "Should be equal to expected value")
  }
  
  func testSHA224() {
    let algorithm:HMACAlgorithm = .SHA224
    let hmac:String = quote.HMAC(algorithm, secret: author)
    XCTAssertEqual(hmac, expectedValues[algorithm]!, "Should be equal to expected value")
  }
  
  func testSHA256() {
    let algorithm:HMACAlgorithm = .SHA256
    let hmac:String = quote.HMAC(algorithm, secret: author)
    XCTAssertEqual(hmac, expectedValues[algorithm]!, "Should be equal to expected value")
  }
  
  func testSHA384() {
    let algorithm:HMACAlgorithm = .SHA384
    let hmac:String = quote.HMAC(algorithm, secret: author)
    XCTAssertEqual(hmac, expectedValues[algorithm]!, "Should be equal to expected value")
  }
  
  func testSHA512() {
    let algorithm:HMACAlgorithm = .SHA512
    let hmac:String = quote.HMAC(algorithm, secret: author)
    XCTAssertEqual(hmac, expectedValues[algorithm]!, "Should be equal to expected value")
  }
}


