#Sweet HMAC

[![Twitter: @jancassio](https://img.shields.io/badge/contact-@jancassio-blue.svg?style=flat)](https://twitter.com/jancassio)
[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/jancassio/SweetHMAC/blob/master/LICENSE)
[![Build](https://api.travis-ci.org/jancassio/SweetHMAC.svg)](https://travis-ci.org/jancassio/SweetHMAC)
![Version](https://cocoapod-badges.herokuapp.com/v/SweetHMAC/badge.png)
![Platforms](https://cocoapod-badges.herokuapp.com/p/SweetHMAC/badge.png)

`SweetHMAC` is a tiny and easy to use Swift class to encrypt strings using HMAC algorithms.
A special thanks to [jernejstrasner](https://gist.github.com/jernejstrasner) for shared [HMACDigest Gist](https://gist.github.com/jernejstrasner/1d5fa5e2fabda2e729d1), that inspired to create this simple class and String extension.

## Usage examples

There are two ways to use Sweet HMAC in your projects

### 1. by String extension
```swift
// Will output this string: e470f785afb708cd8c2a31860642fd11
"I'm going to make him an offer he can't refuse".HMAC(.MD5, secret:"Vito Corleone")
```
	
### 2. by SweetHMAC class

```swift
let quote = "I'm going to make him an offer he can't refuse"
let author = "Vito Corleone"

// Create a SweetHMAC instance with your message and secret strings
let hmacEncrypt:SweetHMAC = SweetHMAC(source: quote, secret: author)

// Pick some computed HMAC output based on some algorithm using "HMAC" method...
let md5 = hmacEncrypt.HMAC(.MD5)

// ...or do it more "Sweet" like this
let md5 = SweetHMAC(source: quote, secret: author).HMAC(.MD5)
```

## Supported HMAC algorithms

* MD5
* SHA1
* SHA224
* SHA256
* SHA384
* SHA512

## Considerations

* I'm not tested this class in Mac and I don't see any reason to SweetHMAC not work in Mac OS X projects, feel free to fork this project an run tests over Mac OS X platform.


## License

Copyright (c) 2014 Jan Cassio. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
