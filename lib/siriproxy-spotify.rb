# -*- encoding : utf-8 -*-
require 'cora'
require 'siri_objects'
require 'open-uri'
require 'json'
require 'uri'


class SiriProxy::Plugin::Spotify < SiriProxy::Plugin
  def initialize(config)
    #if you have custom configuration options, process them here!
  end
begin
listen_for /(Radio) (.*)/i do |junk,input|

find = URI.escape(input.strip)
results = JSON.parse(open("http://ws.spotify.com/search/1/track.json?q=#{find}").read)

track = results["tracks"][0]
puts
puts
puts track["name"]
puts track["href"]
puts "#{find}"
puts
system "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.OpenUri string:#{track["href"]}"
say "C'est fait, j'ai mis #{track["name"]} de #{track["artists"][0]["name"]}"
end     
rescue Exception=>e

          say "Désolé, une erreur est survenue. #{$Exception}"    
   request_completed
   end
 end

