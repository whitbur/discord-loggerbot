#!/usr/bin/env ruby

require 'elasticsearch'
require 'pry'

client = Elasticsearch::Client.new log: true
binding.pry
