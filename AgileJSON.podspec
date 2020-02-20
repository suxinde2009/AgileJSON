Pod::Spec.new do |s|

  s.name         = "AgileJSON"
  s.version      = "0.1.1"
  s.summary      = "AgileJSON, a replacement of HandyJSON, WIP..."

  s.homepage     = "https://github.com/suxinde2009/AgileJSON"
  s.license      = "MIT"
  s.author             = { "suxinde2009" => "suxinde2009@126.com" }
  s.source       = { :git => "https://github.com/suxinde2009/AgileJSON.git", :tag => "#{s.version}" }
  
  s.swift_version = "4.0"
  s.ios.deployment_target = "9.0"
  
  s.source_files  = "AgileJSON/**/*.h", "Source/**/*.{h,m,swift}"
  s.public_header_files = "AgileJSON/**/*.h", "Source/**/*.h"

end
