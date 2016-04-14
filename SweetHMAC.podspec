Pod::Spec.new do |spec|
  spec.name = 'SweetHMAC'
  spec.version = '1.2'
  spec.license = 'MIT'
  spec.summary = 'A tiny and easy to use Swift class to encrypt strings using HMAC algorithms.'
  spec.homepage = 'https://github.com/jancassio/SweetHMAC'
  spec.social_media_url ='http://www.twitter.com/jancassio'
  spec.authors = { 'Jan Cassio' => 'hey@jancassio.com' }
  spec.source = { :git => 'https://github.com/jancassio/SweetHMAC.git', :tag => spec.version }

  spec.ios.deployment_target = '8.0'
  spec.osx.deployment_target = '10.10'

  spec.source_files = "SweetHMAC/Source"
  spec.framework    = "SystemConfiguration"
  spec.module_name  = "CommonCrypto"

  spec.requires_arc = true

end
