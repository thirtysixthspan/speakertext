#!/usr/bin/env ruby

require 'speaker_text'

if ARGV.size<1
  puts "#{$0} [SpeakerText Transcript ID]"
  exit
end

id = ARGV[0]
puts "Fetching SpeakerText transcript ID #{id}"

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
success, content = st.fetch_xml_transcript(id: id);
if success
  filename = "#{id}.xml"
  File.open(filename, 'w') do |file|
    file.write(content)
  end
  puts "Success: saved transcript to #{filename}"
else
  puts "Error: #{content}"
end



