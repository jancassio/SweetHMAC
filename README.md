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
"I'm going to make him an offer he can't refuse".HMAC(.md5, secret:"Vito Corleone")
```

### 2. by SweetHMAC class

```swift
let quote = "I'm going to make him an offer he can't refuse"
let author = "Vito Corleone"

// Create a SweetHMAC instance with your message and secret strings
let digest:SweetHMAC = SweetHMAC(message: quote, secret: author)

// Pick some computed HMAC output based on some algorithm using "HMAC" method...
let md5 = digest.HMAC(algorithm: .md5)

// ...or do it more "Sweet" like this
let md5 = SweetHMAC(message: quote, secret: author).HMAC(.MD5)
```

## Supported HMAC algorithms

* MD5
* SHA1
* SHA224
* SHA256
* SHA384
* SHA512

## Installation

SweetHMAC have many clear and simple options to be used in any iOS or OSX projects.

##Using dependency manager
Actually SweetHMAC can be used with those dependency managers
* CocoaPods
* Carthage

###CocoaPods

You can use SweetHMAC with CocoaPods, specify your `Podfile` like this:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'SweetHMAC', '~> 3.0'
```

##Carthage

Also you can use Carthage to SweetHMAC framework at your project, just add SweetHMac in your `Cartfile` file like this:

`github "jancassio/SweetHMAC" >= 3.0`

##Integrated Project

As many iOS/OSX projects, you can add third party libraries in your project as well.

###Embeded Framework

You can add SweetHMAC as submodule (preferred) or paste entire SweetHMAC project relative to your Xcode project, choose one of both options and after them:

  1. Drag `SweetHMAC.xcodeproj` from SweetHMAC folder to your project.
  2. At Xcode, open _"Project Navigator"_ (⌘+1).
  3. Select SweetHMAC project (the blue project icon).
  4. Check if SweetHMAC deployment target matches your project deployment target.
  5. At this point, select _"Build Phases"_ tab.
  6. Click on **+** icon to add a new _"Copy Phase"_. Optional: Rename this phase to _"Embeded Frameworks"_.
  7. Set destination to _"Frameworks"_.
  8. Add `SweetHMAC.framework`.

### Source file

This is not the preferred option to add SweetHMAC in your project, because SweetHMAC depends by CommonCrypto lib to work properly and, Swift can't access this lib directly.

So if you still want to use SweetHMAC by source files, follow steps below:

  1. At Xcode, open _"Project Navigator"_ (⌘+1).
  2. Select your project file (the blue project icon).
  3. Click on _"Build Phases"_ tab.
  4. Create a new _"Run Script"_ phase clicking on **+** icon.
  5. Drag the run script phase created to stay below the first phase (ak _"Target dependencies"_).
  6. Paste the code below at run script phase created before:

  ```shell
  COMMOM_CRYPTO_PATH=$SDKROOT/usr/include/CommonCrypto/CommonCrypto.h
  COMMOM_CRYPTO_R_PATH=$SDKROOT/usr/include/CommonCrypto/CommonRandom.h

  MODULE_DIR="$SRCROOT/Modules/CommonCrypto"
  MODULE_FILE=$MODULE_DIR/module.map
  MODULE_TEMPLATE="module CommonCrypto [system] {\n\t
    header \"$COMMOM_CRYPTO_PATH\"\n\t
    header \"$COMMOM_CRYPTO_R_PATH\"\n\t
    export *\n
  }"

  echo "Create Modules path to map CommonCrypto lib"
  mkdir -p "$SRCROOT/Modules/CommonCrypto"

  echo "Cleanup previous CommonCrypto script to make sure the deployment target is always updated"

  echo "" > $MODULE_FILE

  echo "Create CommonCrypto module map template"
  echo -e $MODULE_TEMPLATE > $MODULE_FILE
  ```

  7. Create a new file (⌘+N).
  8. Select _"iOS"_/_"Others"_.
  9. Select _"Congfiguration Settings File"_.
  10. Put any name you want.
  10. Add the content below in Configuration file created before:
  ```
  SWIFT_INCLUDE_PATHS="$SRCROOT/Modules"
  ```
  12. Go to your project file in _"Project Navigator"_ (⌘+1)
  13. Select your project file and select your project above your project targets.
  14. Change configurations for the last one you created for each target you are using SweetHMAC by source.
  15. Build your project.

###Quick Observation
Each time you change your deployment device for example, from Simulator to Device, you should build your project, because the script added in build phase, will use the current operational system selected in your Xcode scheme to construct the absolute path to the CommonCrypto header relative of Simulator SDK or iPhoneOS SDK.

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
