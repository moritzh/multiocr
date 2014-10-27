Gem::Specification.new do |s|
  s.name        = 'textractor'
  s.version     = '0.0.1'
  s.date        = '2014-10-27'
  s.summary     = "Fuzzy OCR using several tries"
  s.authors     = ["Moritz Haarmann"]
  s.email       = 'post@moritzhaarmann.de'
  s.files        = Dir.glob("{lib}/**/*") + %w(LICENSE Readme.md)
  s.homepage    =
    'http://github.com/moritzh/textractor'
  s.license       = 'BSD'
  
  s.add_runtime_dependency 'tesseract-ocr'
  s.add_runtime_dependency 'rmagick'
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
  
end