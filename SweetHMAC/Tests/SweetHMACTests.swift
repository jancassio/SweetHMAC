//
//  SweetHMACTests.swift
//  SweetHMACTests
//
//  Copyright (c) 2014 Jan Cassio. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import XCTest
import SweetHMAC

/**
 The challenge 1 is structure, is designed to test HMAC with message and key.
 */
struct Challenge1 {
  static let quote = "I'm going to make him an offer he can't refuse"
  static let author = "Vito Corleone"
  
  static let expectedValues:[HMACAlgorithm:String] = [
    .md5      :"e470f785afb708cd8c2a31860642fd11",
    .sha1     :"708d7175e4f1e8b9d26f3b4f36222f7cef17cdc6",
    .sha224   :"e85406784fd773f76b236df5614505b1027506750f75152bf06554d3",
    .sha256   :"31f2f1fe65304c1960a5f49600a8c6f19d013b9ea42dc94407b26fc347b1ce42",
    .sha384   :"234eeb30d96f5c09c501e9defa590f8f3a5e91455c84484639ded7f4f8b8b2c3714a803d42b503d10149a9422923a5e2",
    .sha512   :"a978a70f3fa49880982f0e57d12d96066b281e590812a01af19aeab4db9637f0eaa7dbab3d975c4841f4b59e4879fc56bbedee6326fb598b8ffb1a914c8e0f46"
  ]
}

/**
 The second challenge is for hash from string tests.
 */
struct Challenge2 {
  static let quote = "The quick brown fox jumps over the lazy dog"
  
  static let expectedValues:[HMACAlgorithm:String] = [
    .md5      :"9e107d9d372bb6826bd81d3542a419d6",
    .sha1     :"2fd4e1c67a2d28fced849ee1bb76e7391b93eb12",
    .sha224   :"730e109bd7a8a32b1cb9d9a09aa2325d2430587ddbc0c38bad911525",
    .sha256   :"d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592",
    .sha384   :"ca737f1014a48f4c0b6dd43cb177b0afd9e5169367544c494011e3317dbf9a509cb1e5dc1e85a941bbee3d7f2afbc9b1",
    .sha512   :"07e547d9586f6a73f73fbac0435ed76951218fb7d0c8d788a309d785436bbb642e93a252a954f23912547d1e8a3b5ed6e1bfd7097821233fa0538f3db854fee6"
  ]
}



class SweetHMACTest: XCTestCase {
  
  func testMD5Hash () {
    let algorithm: HMACAlgorithm = .md5
    let hash: String = SweetHMAC.MD5(input: Challenge2.quote)
    
    XCTAssertEqual(hash, Challenge2.expectedValues[algorithm], "Should be equal to expected value")
  }
  
  func testSHA1Hash () {
    let algorithm: HMACAlgorithm = .sha1
    let hash: String = SweetHMAC.SHA1(input: Challenge2.quote)
    
    XCTAssertEqual(hash, Challenge2.expectedValues[algorithm], "Should be equal to expected value")
  }
  
  func testSHA224Hash () {
    let algorithm: HMACAlgorithm = .sha224
    let hash: String = SweetHMAC.SHA224(input: Challenge2.quote)
    
    XCTAssertEqual(hash, Challenge2.expectedValues[algorithm], "Should be equal to expected value")
  }
  
  func testSHA256Hash () {
    let algorithm: HMACAlgorithm = .sha256
    let hash: String = SweetHMAC.SHA256(input: Challenge2.quote)
    
    XCTAssertEqual(hash, Challenge2.expectedValues[algorithm], "Should be equal to expected value")
  }
  
  func testSHA384Hash () {
    let algorithm: HMACAlgorithm = .sha384
    let hash: String = SweetHMAC.SHA384(input: Challenge2.quote)
    
    XCTAssertEqual(hash, Challenge2.expectedValues[algorithm], "Should be equal to expected value")
  }
  
  func testSHA512Hash () {
    let algorithm: HMACAlgorithm = .sha512
    let hash: String = SweetHMAC.SHA512(input: Challenge2.quote)
    
    XCTAssertEqual(hash, Challenge2.expectedValues[algorithm], "Should be equal to expected value")
  }
  
  func testMD5WithSecret() {
    let algorithm:HMACAlgorithm = .md5
    let hmac = SweetHMAC(
      message: Challenge1.quote,
      secret: Challenge1.author
        ).HMAC(algorithm: algorithm)
    
    XCTAssertEqual(
      hmac,
      Challenge1.expectedValues[algorithm]!,
      "Should be equal to expected value"
    )
  }
  
  func testSHA1WithSecret() {
    let algorithm:HMACAlgorithm = .sha1
    let hmac:String = SweetHMAC(
      message: Challenge1.quote,
      secret: Challenge1.author
      ).HMAC(algorithm: algorithm)
    
    XCTAssertEqual(
      hmac,
      Challenge1.expectedValues[algorithm]!,
      "Should be equal to expected value"
    )
  }
  
  func testSHA224WithSecret() {
    let algorithm:HMACAlgorithm = .sha224
    let hmac:String = SweetHMAC(
      message: Challenge1.quote,
      secret: Challenge1.author
      ).HMAC(algorithm: algorithm)
    
    XCTAssertEqual(
      hmac,
      Challenge1.expectedValues[algorithm]!,
      "Should be equal to expected value"
    )
  }
  
  func testSHA256WithSecret() {
    let algorithm:HMACAlgorithm = .sha256
    let hmac:String = SweetHMAC(
      message: Challenge1.quote,
      secret: Challenge1.author
      ).HMAC(algorithm: algorithm)
    
    XCTAssertEqual(
      hmac,
      Challenge1.expectedValues[algorithm]!,
      "Should be equal to expected value"
    )
  }
  
  func testSHA384WithSecret() {
    let algorithm:HMACAlgorithm = .sha384
    let hmac:String = SweetHMAC(
      message: Challenge1.quote,
      secret: Challenge1.author
      ).HMAC(algorithm: algorithm)
    
    XCTAssertEqual(
      hmac,
      Challenge1.expectedValues[algorithm]!,
      "Should be equal to expected value"
    )
  }
  
  func testSHA512WithSecret() {
    let algorithm:HMACAlgorithm = .sha512
    let hmac:String = SweetHMAC(
      message: Challenge1.quote,
      secret: Challenge1.author
      ).HMAC(algorithm: algorithm)
    XCTAssertEqual(
      hmac,
      Challenge1.expectedValues[algorithm]!,
      "Should be equal to expected value"
    )
  }
}




class SweetHMACStringExtensionTests: XCTestCase {
  
  func testMD5Hash () {
    let hash = Challenge2.quote.MD5()
    
    XCTAssertEqual(
      hash,
      Challenge2.expectedValues[.md5]!,
      "Should be equal to expected value"
    )
  }
  
  func testSHA1Hash () {
    let hash = Challenge2.quote.SHA1()
    
    XCTAssertEqual(
      hash,
      Challenge2.expectedValues[.sha1]!,
      "Should be equal to expected value"
    )
  }
  
  func testSHA224Hash () {
    let hash = Challenge2.quote.SHA224()
    
    XCTAssertEqual(
      hash,
      Challenge2.expectedValues[.sha224]!,
      "Should be equal to expected value"
    )
  }
  
  func testSHA256Hash () {
    let hash = Challenge2.quote.SHA256()
    
    XCTAssertEqual(
      hash,
      Challenge2.expectedValues[.sha256]!,
      "Should be equal to expected value"
    )
  }
  
  func testSHA384Hash () {
    let hash = Challenge2.quote.SHA384()
    
    XCTAssertEqual(
      hash,
      Challenge2.expectedValues[.sha384]!,
      "Should be equal to expected value"
    )
  }
  
  func testSHA512Hash () {
    let hash = Challenge2.quote.SHA512()
    
    XCTAssertEqual(
      hash,
      Challenge2.expectedValues[.sha512]!,
      "Should be equal to expected value"
    )
  }
  
  func testMD5WithSecret() {
    let algorithm:HMACAlgorithm = .md5
    let hmac:String = Challenge1.quote.HMAC(
      algorithm: algorithm,
      secret: Challenge1.author
    )
    
    XCTAssertEqual(
      hmac,
      Challenge1.expectedValues[.md5]!,
      "Should be equal to expected value"
    )
  }
  
  func testSHA1WithSecret() {
    let algorithm:HMACAlgorithm = .sha1
    let hmac:String = Challenge1.quote.HMAC(
      algorithm: algorithm,
      secret: Challenge1.author
    )
    
    XCTAssertEqual(
      hmac, Challenge1.expectedValues[algorithm]!,
      "Should be equal to expected value"
    )
  }
  
  func testSHA224WithSecret () {
    let algorithm:HMACAlgorithm = .sha224
    let hmac:String = Challenge1.quote.HMAC(
        algorithm: algorithm,
        secret: Challenge1.author
    )
    
    XCTAssertEqual(
      hmac,
      Challenge1.expectedValues[algorithm]!,
      "Should be equal to expected value"
    )
  }
  
  func testSHA256WithSecret() {
    let algorithm:HMACAlgorithm = .sha256
    let hmac:String = Challenge1.quote.HMAC(
      algorithm: algorithm,
      secret: Challenge1.author
    )
    
    XCTAssertEqual(
      hmac,
      Challenge1.expectedValues[algorithm]!,
      "Should be equal to expected value"
    )
  }
  
  func testSHA384WithSecret() {
    let algorithm:HMACAlgorithm = .sha384
    let hmac:String = Challenge1.quote.HMAC(
      algorithm: algorithm,
      secret: Challenge1.author
    )
    
    XCTAssertEqual(
      hmac,
      Challenge1.expectedValues[algorithm]!,
      "Should be equal to expected value"
    )
  }
  
  func testSHA512WithSecret() {
    let algorithm:HMACAlgorithm = .sha512
    let hmac:String = Challenge1.quote.HMAC(
      algorithm: algorithm,
      secret: Challenge1.author
    )
    
    XCTAssertEqual(
      hmac,
      Challenge1.expectedValues[algorithm]!,
      "Should be equal to expected value"
    )
  }
}


