#= require jquery
#= require_self

track = 'new-home'

$ ->
  # Check for HTML5 audio
  canPlayAudio = document.createElement('audio').canPlayType
  alert "Can't play audio." unless canPlayAudio
  
  # Add audio element
  audioHTML = "<audio id=\"audio\">\
      <source src=\"http://assets.samsoff.es/music/#{track}.ogg\" type=\"audio/ogg\"></source>\
      <source src=\"http://assets.samsoff.es/music/#{track}.mp3\" type=\"audio/mpeg\"></source>\
      <source src=\"http://assets.samsoff.es/music/#{track}.wav\" type=\"audio/x-wav\"></source>\
    </audio>"
  $(audioHTML).insertAfter("div#player")
  
  # Setuip audio bindings
  jAudio = $("audio#audio")
  audio = jAudio[0]
  
  # Update progress
  waveformFill = $("div#waveform-fill")
  jAudio.bind 'timeupdate', ->
     waveformFill.css("width", "#{audio.currentTime}%")
  
  # Add waveform
  $("div#waveform").css("background", "url(http://assets.samsoff.es/music/#{track}.png) no-repeat")
  
  # Add actions
  $("div#waveform-container").click ->
    audio.play()
