require 'digest/sha1'

module SponsorPay
  class Request 
    attr_reader :uri,:query_string, :params
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
  end
end