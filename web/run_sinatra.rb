require 'unirest'
require 'sinatra'
require 'json'

url = ENV['ELASTICSEARCH_URL'] || 'http://localhost:9200'

set :bind, '0.0.0.0'
set :port, 80
set :environment, :production

get '/' do
  File.read(File.join('public', 'index.html'))
end

post '/query' do
  data = JSON.parse(request.body.read)
  query = {
    size: (data['size'] or 1000),
    from: (data['from'] or 0),
    sort: [{timestamp:'desc'}],
    timeout: '10s',
    query: {
      query_string: {
        query: data['query'],
        default_operator:'and'
      }
    }
  }
  response = Unirest.post url+'/discord/message/_search', parameters:query.to_json
  response.body['hits']['hits'].map{|h|h['_source']}.to_json
end

get '/channels' do
  response = Unirest.post url+'/discord/message/_search', parameters:{query:{exists:{ field:'server'}},aggs:{message:{terms:{field:'channel',size:30}}}}.to_json
  response.body['aggregations']['message']['buckets'].map{|b| b['key']}.to_json
end
