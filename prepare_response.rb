require 'json'

myjson = JSON.parse File.open('response.json','r:utf-8').read

puts myjson.to_json