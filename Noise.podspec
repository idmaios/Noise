Pod::Spec.new do |s|
  s.name          = "Noise"
  s.version       = "0.4.2"
  s.summary       = "iOS in application notifications. Based on NSOperationQueue."
  s.homepage      = "https://github.com/idmaios/Noise"
  s.license       = 'MIT'
  s.author        = { "spromicky" => "spromicky@gmail.com" }
  s.source        = { :git => "https://github.com/idmaios/Noise", :tag => s.version.to_s }

  s.swift_version = '4.0'
  s.platform      = :ios, '11.0'
  s.requires_arc  = true

  s.source_files  = 'Noise/Sources/Noise/**/*.swift'
  s.resources     = 'Noise/Sources/Noise/View/*.xib'
end