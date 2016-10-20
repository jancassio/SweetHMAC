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

#if os(OSX)
  import CommonCryptoMacOSX
#elseif os(iOS)
  #if (arch(i386) || arch(x86_64))
    import CommonCryptoiPhoneSimulator
  #else
    import CommonCryptoiPhoneOS
  #endif
  
#endif

public extension String {
  
  /**
   Proved a string for some HMAC algorithm and secret string.
   
   - parameter algorithm: Some HMAC algorithm. Supported types are:
   
   - MD5
   - SHA1
   - SHA224
   - SHA256
   - SHA384
   - SHA512
   
   - parameter secret: A secret message to authenticate the encrypted message.
   
   - returns: A encryped string based on HMAC algorithm and secret string.
   */
  func HMAC(algorithm:HMACAlgorithm, secret:String) -> String {
    return SweetHMAC(message: self, secret: secret).HMAC(algorithm: algorithm)
  }
  
  func MD5 () -> String {
    return SweetHMAC.MD5(input: self)
  }
  
  func SHA1 () -> String {
    return SweetHMAC.SHA1(input: self)
  }
  
  func SHA224 () -> String {
    return SweetHMAC.SHA224(input: self)
  }
  
  func SHA256 () -> String {
    return SweetHMAC.SHA256(input: self)
  }
  
  func SHA384 () -> String {
    return SweetHMAC.SHA384(input: self)
  }
  
  func SHA512 () -> String {
    return SweetHMAC.SHA512(input: self)
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
  case md5, sha1, sha224, sha256, sha384, sha512
  
  /**
   Give the native value for HMACAlgorithm value
   
   - returns: The system `CCHmacAlgorithm` native value.
   */
  func toNative () -> CCHmacAlgorithm {
    switch self {
    case .md5:
      return CCHmacAlgorithm( kCCHmacAlgMD5 )
      
    case .sha1:
      return CCHmacAlgorithm( kCCHmacAlgSHA1 )
      
    case .sha224:
      return CCHmacAlgorithm( kCCHmacAlgSHA224 )
      
    case .sha256:
      return CCHmacAlgorithm( kCCHmacAlgSHA256 )
      
    case .sha384:
      return CCHmacAlgorithm( kCCHmacAlgSHA384 )
      
    case .sha512:
      return CCHmacAlgorithm( kCCHmacAlgSHA512 )
    }
  }
  
  func digestLength () -> Int {
    switch self {
    case .md5:
      return Int( CC_MD5_DIGEST_LENGTH )
      
    case .sha1:
      return Int( CC_SHA1_DIGEST_LENGTH )
      
    case .sha224:
      return Int( CC_SHA224_DIGEST_LENGTH )
      
    case .sha256:
      return Int( CC_SHA256_DIGEST_LENGTH )
      
    case .sha384:
      return Int( CC_SHA384_DIGEST_LENGTH )
      
    case .sha512:
      return Int( CC_SHA512_DIGEST_LENGTH )
    }
  }
}

/// A simple class to encrypt strings using HMAC algorithms.
public class SweetHMAC {
  
  struct UTF8EncodedString {
    
    var data:[CChar]
    var length:Int
    
    public init(string:String) {
      data = string.cString(using: String.Encoding.utf8)!
      length = string.lengthOfBytes(using: String.Encoding.utf8)
    }
  }
  
  
  
  
  /// Message to be encrypted
  fileprivate var message:String = ""
  
  /// Secret message to authenticate the encrypted message.
  fileprivate var secret:String = ""
  
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
    let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLength)
    
    CCHmac(algorithm.toNative(), key.data, key.length, seed.data, seed.length, result)
    
    let hash = NSMutableString()
    
    for i in 0..<digestLength {
      hash.appendFormat("%02x", result[i])
    }
    
    result.deinitialize()
    
    return String( hash )
  }
  
  /**
   Generate MD5 hash from the input string provided.
   - parameter input: The string to be encrypted.
   - returns: A encrypted string.
   */
  public class func MD5 (input: String) -> String {
    return digest(algorithm: .md5, input: input)
  }
  
  /**
   Generate SHA1 hash from the input string provided.
   - parameter input: The string to be encrypted.
   - returns: A encrypted string.
   */
  public class func SHA1 (input: String) -> String {
    return digest(algorithm: .sha1, input: input)
  }
  
  /**
   Generate SHA224 hash from the input string provided.
   - parameter input: The string to be encrypted.
   - returns: A encrypted string.
   */
  public class func SHA224 (input: String) -> String {
    return digest(algorithm: .sha224, input: input)
  }
  
  /**
   Generate SHA256 hash from the input string provided.
   - parameter input: The string to be encrypted.
   - returns: A encrypted string.
   */
  public class func SHA256 (input: String) -> String {
    return digest(algorithm: .sha256, input: input)
  }
  
  /**
   Generate SHA384 hash from the input string provided.
   - parameter input: The string to be encrypted.
   - returns: A encrypted string.
   */
  public class func SHA384 (input: String) -> String {
    return digest(algorithm: .sha384, input: input)
  }
  
  /**
   Generate SHA512 hash from the input string provided.
   - parameter input: The string to be encrypted.
   - returns: A encrypted string.
   */
  public class func SHA512 (input: String) -> String {
    return digest(algorithm: .sha512, input: input)
  }
  
  
  /**
   Generate abstraction for static methods
   - parameter algorithm: Algorithm to encrypt message.
   - parameter input: The string to be encrypted.
   - returns: A encrypted string.
   */
  public class func digest (algorithm: HMACAlgorithm, input: String) -> String {
    let seed  = UTF8EncodedString(string: input)
    let digestLength = algorithm.digestLength()
    
    let result = UnsafeMutablePointer<UInt8>.allocate(capacity: digestLength)
    
    switch algorithm {
    case .md5:
      CC_MD5(seed.data, CC_LONG(seed.length), result)
      break
      
    case .sha1:
      CC_SHA1(seed.data, CC_LONG(seed.length), result)
      break
      
    case .sha224:
      CC_SHA224(seed.data, CC_LONG(seed.length), result)
      break
      
    case .sha256:
      CC_SHA256(seed.data, CC_LONG(seed.length), result)
      break
      
    case .sha384:
      CC_SHA384(seed.data, CC_LONG(seed.length), result)
      break
      
    case .sha512:
      CC_SHA512(seed.data, CC_LONG(seed.length), result)
      break
    }
    
    let hash = NSMutableString()
    
    for i in 0..<digestLength {
      hash.appendFormat("%02x", result[i])
    }
    
    result.deinitialize()
    
    return String( hash )
  }
}
