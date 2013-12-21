# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xvideos_helper/version'

Gem::Specification.new do |spec|
  spec.name          = "xvideos_helper"
  spec.version       = XvideosHelper::VERSION
  spec.authors       = ["YuheiNakasaka"]
  spec.email         = ["yuhei.nakasaka@gmail.com"]
  spec.description   = %q{xvideos_helper is a gem to support for adult site creater.}
  spec.summary       = %q{This gem get movie infomation from xvideo.com.}
  spec.homepage      = "https://github.com/YuheiNakasaka/xvideos_helper"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "nokogiri"
end
