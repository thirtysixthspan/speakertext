require File.expand_path('../lib/speaker_text', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'speaker_text'
  s.version     = SpeakerText::VERSION
  s.date        = '2011-11-24'
  s.homepage    = 'http://github.com/thirtysixthspan/speakertext'
  s.summary     = 'SpeakerText API Wrapper Gem'
  s.description = 'A gem to automate transcription of audio and video media using the SpeakerText.com service.'
  s.authors     = ['Derrick Parkhurst']
  s.email       = 'derrick.parkhurst@gmail.com'
  s.platform    = Gem::Platform::RUBY
  s.files       = Dir.glob('{lib,examples}/**/*') + %w[LICENSE README.md]
  s.add_dependency 'uuidtools', '~> 2.1.2'
  s.add_dependency 'httparty', '~> 0.8.1'
  s.require_paths = ["lib"]
end

