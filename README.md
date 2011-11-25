SpeakerText Gem
===============

  A gem to automate transcription of audio and video media using the [SpeakerText service](http://speakertext.com) 
and [SpeakerText API](http://speakertext.com/api).

Overview
--------
  
  Audio and video media hosted on the Internet are not well indexed by search engines and thus not easily 
searchable. For a fee, the SpeakerText.com service produces text transcripts of audio and video content that 
is available on the Internet (on a private website or a media hosting service such as YouTube). These text 
transcripts can be used to augment media, thus making them searchable and indexed by search engines. Using
the SpeakerText video player, the trascripts can also be used as subtitles increasing access of audio and 
video media to hearing impared individuals.

Requires
--------

* A SpeakerText account and API key
* Credits purchased through the [SpeakerText website](http://speakertext.com)
* [HTTParty gem](http://github.com/jnunemaker/httparty)
* [UUIDTools gem](http://github.com/sporkmonger/uuidtools)
* Ruby >= 1.9.2

Usage Examples
--------------

Initialize the API with a key

    st = SpeakerText.new(your_api_key)

Submit a media file URL for transcription

    success, transcript_id = st.transcribe(url: public_url_of_media_file)

Submit a media file hosted on a platform (e.g., YouTube, Vimeo, SoundCloud)

    status, transcript_id = st.transcribe(platform: 'youtube', id: youtube_video_id)

Check the status of the transcription process

    success, status = st.transcript_status(id: transcript_id)

Request the completed transcripts

    success, content = st.transcript(id: transcript_id)

See also the [examples](https://github.com/thirtysixthspan/speakertext/tree/master/examples)


License
-------
Copyright (c) 2011 Derrick Parkhurst (derrick.parkhurst@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
