#!/usr/bin/env ruby

require 'json'
require 'unirest'
require 'discordrb'

url = ENV['ELASTICSEARCH_URL'] || 'http://localhost:9200'

bot = Discordrb::Bot.new token: '#REDACTED#', application_id: #REDACTED#

bot.message() do |event|
    scrub_mentions(bot, event)
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

def scrub_mentions(bot, event)
    begin
        while (event.text[/<@!?(\d+)>/]) do
            uid = $1.to_i
            user = bot.user(uid)
            member = bot.member(event.server, uid)
            display_name = member ? '@'+member.display_name : "@%s#%s"%[user.username,user.discriminator]
            event.text.gsub!(/<@!?#{uid}>/, display_name)
        end
    rescue => ex
        puts ex.message
    end
end

bot.run
