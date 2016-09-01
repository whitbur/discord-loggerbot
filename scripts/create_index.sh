#!/bin/bash

curl -XPUT 'localhost:9200/discord' -d '
{
  "settings": {
    "index": {
      "number_of_shards": 1,
      "number_of_replicas": 0
    }
  },
  "mappings" : {
    "message" : {
      "_ttl" : {
        "enabled" : true,
        "default" : 5184000000
      },
      "properties" : {
        "channel" : {
          "type" : "string",
          "index": "not_analyzed"
        },
        "discriminator" : {
          "type" : "string",
          "index": "not_analyzed"
        },
        "server" : {
          "type" : "string",
          "index": "not_analyzed"
        },
        "text" : {
          "type" : "string"
        },
        "timestamp" : {
          "type" : "date",
          "format" : "strict_date_optional_time||epoch_millis"
        },
        "username" : {
          "type" : "string",
          "index": "not_analyzed"
        },
        "nickname" : {
          "type" : "string",
          "index": "not_analyzed"
        }
      }
    }
  }
}'
