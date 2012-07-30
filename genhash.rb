require 'digest/sha1'

API_KEY = "b07a12df7d52e6c118e5d47d3f9e60135b109a1f"

params = {
  appid: "157",
  format: "json",
  device_id: "2b6f0cc904d137be2e1730235f5664094b831186" ,
  locale: "de",
  ip: "109.235.143.113" ,
  offer_types: "112",
  uid: "player1",
  timestamp: Time.now.to_i,
}

query_str = params.keys.sort.collect { |p|
  "#{p}=#{params[p.to_sym]}"
}.join("&") 

hash_key = Digest::SHA1::hexdigest(query_str + "&#{API_KEY}")

puts "http://api.sponsorpay.com/feed/v1/offers.json?#{query_str}&hashkey=#{hash_key}"