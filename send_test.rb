require 'net/http'
require 'uri'
Net::HTTP.get_print URI.parse("http://api.sponsorpay.com/feed/v1/offers.json?appid=157&format=json&device_id=2b6f0cc904d137be2e1730235f5664094b831186&locale=de&ip=109.235.143.113&offer_types=112&ps_time=1312211903&pub0=campaign2&uid=player1&timestamp=#{Time.now.to_i}&page=2&locale=de&hashkey=5004d8b11e6bef26b1ad96bc17ade94763c9cf61")
