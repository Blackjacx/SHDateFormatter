Pod::Spec.new do |s|
  s.name             = 'SHDateFormatter'
  s.version          = '0.9.0'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.summary          = 'A short description of SHDateFormatter.'
  s.description      = <<-DESC
A date formatter supporting encoding as well as decoding of many different date and time formats including the often used ISO8601 standard.
                       DESC
  s.homepage         = 'https://github.com/blackjacx/SHDateFormatter'
  s.social_media_url = 'https://twitter.com/Blackjacxxx'
  s.author           = { 'Stefan Herold' => 'stefan.herold@gmail.com' }
  s.source           = { :git => 'https://github.com/blackjacx/SHDateFormatter.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/**/*'
end
