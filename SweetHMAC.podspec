projectName = "SweetHMAC"

Pod::Spec.new do |spec|
  spec.name               = "#{projectName}"
  spec.version            = "1.3"
  spec.license            = "MIT"
  spec.summary            = "A tiny and easy to use Swift class to encrypt strings using HMAC algorithms."
  spec.homepage           = "https://github.com/jancassio/#{projectName}"
  spec.social_media_url   = "http://www.twitter.com/jancassio/"
  spec.authors            = { "Jan Cassio" => "hey@jancassio.com" }
  spec.source             = { :git => "https://github.com/jancassio/SweetHMAC.git", :tag => spec.version }
  spec.requires_arc       = true

  spec.ios.deployment_target = "8.1"
  spec.osx.deployment_target = "10.11"

  spec.source_files     = "#{projectName}/Source"
  spec.module_name      = "#{projectName}"
  spec.libraries        = 'CommonCrypto'
  # spec.prepare_command  = "sh setup.sh"

  spec.preserve_paths = "#{projectName}/CommonCrypto/*"
  spec.pod_target_xcconfig = {
    "HEADER_SEARCH_PATHS" => "$(PODS_ROOT)/#{projectName}/module",
    "SWIFT_INCLUDE_PATHS[sdk=macosx*]"           => "$(SRCROOT)/#{projectName}/CommonCrypto/module",
    "SWIFT_INCLUDE_PATHS[sdk=iphoneos*]"         => "$(SRCROOT)/#{projectName}/CommonCrypto/module",
    "SWIFT_INCLUDE_PATHS[sdk=iphonesimulator*]"  => "$(SRCROOT)/#{projectName}/CommonCrypto/module",
  }

end
