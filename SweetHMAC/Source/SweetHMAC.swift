//
//  SweetHMAC.swift
//  SweetHMAC
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


/*
Special thanks to jernejstrasner to provide the gist that inspired this approach
URL: https://gist.github.com/jernejstrasner/1d5fa5e2fabda2e729d1
*/

import Foundation
import CommonCrypto

public extension String {
  
  /**
  Proved a string for some HMAC algorithm and secret string.
  
  - parameter algorithm: Some HMAC algorithm. Supported types are:
  
  - MD5
  - SHA1
  - SHA224
  - SHA256
  - SHA348
  - SHA512
  
  - parameter secret: A secret message to authenticate the encrypted message.
  
  - returns: A encryped string based on HMAC algorithm and secret string.
  */
  func HMAC(algorithm:HMACAlgorithm, secret:String) -> String {
    return SweetHMAC(message: self, secret: secret).HMAC(algorithm)
  }
}




/**
HMACAlgoriths enumerates all HMAC algorithms types supported by iOS (not verified in Mac OS X environment yet)
Supported iOS HMAC algorithms:

- MD5
- SHA1
- SHA224
- SHA256
- SHA348
- SHA512
*/
public enum HMACAlgorithm {
  case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
  
  /**
  Give the native value for HMACAlgorithm value
  
  - returns: The system `CCHmacAlgorithm` native value.
  */
  func toNative () -> CCHmacAlgorithm {
    switch self {
    case .MD5:
      return CCHmacAlgorithm( kCCHmacAlgMD5 )
      
    case .SHA1:
      return CCHmacAlgorithm( kCCHmacAlgSHA1 )
      
    case .SHA224:
      return CCHmacAlgorithm( kCCHmacAlgSHA224 )
      
    case .SHA256:
      return CCHmacAlgorithm( kCCHmacAlgSHA256 )
      
    case .SHA384:
      return CCHmacAlgorithm( kCCHmacAlgSHA384 )
      
    case .SHA512:
      return CCHmacAlgorithm( kCCHmacAlgSHA512 )
    }
  }
  
  func digestLength () -> Int {
    switch self {
    case .MD5:
      return Int( CC_MD5_DIGEST_LENGTH )
      
    case .SHA1:
      return Int( CC_SHA1_DIGEST_LENGTH )
      
    case .SHA224:
      return Int( CC_SHA224_DIGEST_LENGTH )
      
    case .SHA256:
      return Int( CC_SHA256_DIGEST_LENGTH )
      
    case .SHA384:
      return Int( CC_SHA384_DIGEST_LENGTH )
      
    case .SHA512:
      return Int( CC_SHA512_DIGEST_LENGTH )
    }
  }
}

/// A simple class to encrypt strings using HMAC algorithms.
public class SweetHMAC {
  
  struct UTF8EncodedString {
    
    var data:[CChar]
    var length:Int
    
    init(string:String) {
      data = string.cStringUsingEncoding(NSUTF8StringEncoding)!
      length = string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    }
  }
  
  
  
  
  /// Message to be encrypted
  private var message:String!
  
  /// Secret message to authenticate the encrypted message.
  private var secret:String!
  
  /**
  Create a new SweetHMAC instance with given message and secret strings.
  - parameter message: The message to be encrypted.
  - parameter secret: The secret message to authenticate encrypted message.
  */
  public init(message:String, secret:String) {
    self.message = message
    self.secret = secret
  }
  
  /**
  Generate HMAC string with given algorithm.
  - parameter algorithm: Algorithm to encrypt message.
  - returns: A encrypted string.
  */
  public func HMAC(algorithm:HMACAlgorithm) -> String {
    let seed  = UTF8EncodedString(string: message)
    let key   = UTF8EncodedString(string: secret)
    
    let digestLength = algorithm.digestLength()
    let result = UnsafeMutablePointer<CUnsignedChar>.alloc( digestLength )
    
    CCHmac(algorithm.toNative(), key.data, key.length, seed.data, seed.length, result)
    
    let hash = NSMutableString()
    
    for i in 0..<digestLength {
      hash.appendFormat("%02x", result[i])
    }
    
    result.destroy()
    
    return String( hash )
  }
}