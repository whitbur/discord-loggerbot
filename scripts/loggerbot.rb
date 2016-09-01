#!/usr/bin/env ruby

require 'json'
require 'unirest'
require 'discordrb'

url = ENV['ELASTICSEARCH_URL'] || 'http://localhost:9200'

bot = Discordrb::Bot.new token: '#REDACTED#', application_id: #REDACTED#

bot.message() do |event|
    Unirest.post url+'/discord/message/', parameters:{
        username: event.author.username, 
        nickname: event.author.nickname, 
        discriminator: event.author.discriminator,
        text: event.text, 
        server: (event.server.name rescue nil), 
        channel: (event.channel.name rescue nil), 
        timestamp: (event.timestamp.to_f * 1000).to_i 
    }.to_json
end

bot.run
