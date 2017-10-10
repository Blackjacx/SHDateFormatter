Pod::Spec.new do |s|
  s.name             = 'SHDateFormatter'
  s.version          = '1.0.0'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.summary          = 'A date formatter supporting encoding as well as decoding of many different date and time formats including the often used ISO8601 standard.'
  s.description      = <<-DESC
'Date formatting is no easy task because there are a lot of things that can be done wrong. This framework will take this burden from you. With very well tested state of the art code that is used in some highly active and often downloaded apps you don't need to think about date formatting again - never. Promised 🍻'
                       DESC
  s.homepage         = 'https://github.com/blackjacx/SHDateFormatter'
  s.social_media_url = 'https://twitter.com/Blackjacxxx'
  s.author           = { 'Stefan Herold' => 'stefan.herold@gmail.com' }
  s.source           = { :git => 'https://github.com/blackjacx/SHDateFormatter.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/**/*.swift'
end
