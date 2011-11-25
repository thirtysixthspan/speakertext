#!/usr/bin/env ruby

require 'speaker_text'

if ARGV.size<1
  puts "#{$0} [Public URL of audio of video file]"
  exit
end

url = ARGV[0]
puts "Uploading #{url} to SpeakerText for transcription"

config_file = 'speakertext.yaml'
if File.exist?(config_file)
  config = YAML::load(File.open(config_file))
else
  puts "Failed to load #{config_file}"
  exit
end

if !config.include?('api_key') || config['api_key']==''
  puts "You must provide an api_key in #{config_file}"
  exit
end

st = SpeakerText.new(config['api_key'])
success, transcript_id = st.transcribe(url: url)
if success
  puts "Success: Transcript ID is #{transcript_id}"
else
  puts "Error: #{transcript_id}"
end
