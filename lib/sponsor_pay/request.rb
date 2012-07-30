require 'digest/sha1'

module SponsorPay
  API_KEY = "b07a12df7d52e6c118e5d47d3f9e60135b109a1f"
  class Request 
    attr_reader :uri,:query_string, :params, :hashkey
    def initialize(params = {})
      @params = {
        appid: "157",
        format: "json",
        device_id: "2b6f0cc904d137be2e1730235f5664094b831186" ,
        locale: "de",
        ip: "109.235.143.113" ,
        offer_types: "112",
        uid: "player1",
        timestamp: Time.now.to_i,
      }.merge(params)
    end
    def query_string
      @query_string ||=  params.keys.sort.collect { |p|
        "#{p}=#{params[p.to_sym]}"
      }.join("&") 
    end
    def hashkey
      @hashkey ||= Digest::SHA1.hexdigest query_string + "&#{API_KEY}"
    end
    def uri
      @uri ||= "http://api.sponsorpay.com/feed/v1/offers.json?#{query_string}&hashkey=#{hashkey}"
    end
  end
end