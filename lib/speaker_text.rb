require 'httparty'
require 'uuidtools'
require 'json'

class SpeakerText
  include HTTParty
  base_uri "https://api.speakertext.com/v1"
  VERSION = '1.0.2'
  
  def initialize(api_key)
    self.class.basic_auth api_key,'x' 
    @verbose=false
  end

  def verbose
    @verbose=true
  end
  
  def generate_id()
    UUIDTools::UUID.random_create.to_s
  end

  def remote_file_exists(url)
    response = HTTParty.head(url)
    return true if response.code == 200
    false
  end

  def submit_transcription_request(query)
    puts query if @verbose
    response = self.class.post("/transcripts", :query => query)
    return [false, "Unauthorized: API key is incorrect"] if response.code==401
    return [false, "SpeakerText Internal Error"] if response.code==500

    fields = JSON.parse response.body

    return [false, fields['message']] if response.code != 201
    return [true, fields['transcript_ids'][0]]
  end

  def transcribe_platform(args)
    puts "Transcribe Platform" if @verbose
    platform = args[:platform]
    source_id = args[:id]
    return [false, "Source id from #{platform} required"] unless source_id && source_id!=''
    source_annotation = args[:annotation] || ''

    sources = {:platform => platform, 
               :video_id => source_id, 
               :annotation => source_annotation
              }

    query = {}
    query[:sources] = sources.to_json
    query[:pingback_url] = args[:pingback_url] if args.include?(:pingback_url) 
    submit_transcription_request(query)
  end

  def transcribe_url(args)
    puts "Transcribe URL" if @verbose
    url = args[:url]
    return [false, "Cannot access remote file #{url}."] if !remote_file_exists(url)
    source_id = args[:id] || generate_id()
    source_title = args[:title] || File.basename(url)
    source_thumbnail_url = args[:thumb_url] || ''
    return [false, "Cannot access remote thumbnail file #{url}."] if args.include?(:thumb_url) && 
                                                           args[:thumb_url]!='' && 
                                                           !remote_file_exists(thumb_url)
    source_annotation = args[:annotation] || ''

    sources = {:url => url, 
               :ref_id => source_id, 
               :title => source_title,
               :thumb_url => source_thumbnail_url,
               :annotation => source_annotation
              }

    query = {}
    query[:sources] = sources.to_json
    query[:pingback_url] = args[:pingback_url] if args.include?(:pingback_url) 
    submit_transcription_request(query)
  end

  def transcribe(args)
    return transcribe_url(args) if args.include?(:url)
    return transcribe_platform(args) if args.include?(:platform)
    "Missing arguments to transcribe request"
  end

  def transcript(args)
    id = args[:id]
    return [false, 'transcript id required'] unless id && id!=''

    format = args[:format] || 'xml'
 
    response = self.class.get("/transcripts/#{id}", :query => { format: format })
    return [false, "Unauthorized: API key is incorrect"] if response.code==401
    return [false, "SpeakerText Internal Error"] if response.code==500

    fields = JSON.parse response.body
 
    return [false, fields['message']] if response.code != 200
    return [false, fields['status']] if fields['content']==''
    return [true, fields['content']]
  end

  def fetch_transcript(args)
    transcript(args)
  end

  def fetch_xml_transcript(args)
    args.merge!(format: 'xml')
    transcript(args)
  end

  def fetch_text_transcript(args)
    args.merge!(format: 'txt')
    transcript(args)
  end

  def fetch_html_transcript(args)
    args.merge!(format: 'html')
    transcript(args)
  end

  def transcript_status(args)
    id = args[:id]
 
    response = self.class.get("/transcripts/#{id}")
    return [false, "SpeakerText Internal Error"] if response.code==500

    fields = JSON.parse response.body

    return [false, fields['message']] if response.code != 200
    return [true, fields['status']]
  end

end
