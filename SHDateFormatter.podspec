Pod::Spec.new do |s|
  s.name             = 'SHDateFormatter'
  s.version          = '0.0.1'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.summary          = 'A short description of SHDateFormatter.'
  s.description      = <<-DESC
A date formatter with support for the ISO8601 standard as well as many predefined date- and time formats.
                       DESC
  s.homepage         = 'https://github.com/blackjacx/SHDateFormatter'
  s.social_media_url = 'https://twitter.com/Blackjacxxx'
  s.author           = { 'Stefan Herold' => 'stefan.herold@gmail.com' }
  s.source           = { :git => 'https://github.com/blackjacx/SHDateFormatter.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/**/*'
end
