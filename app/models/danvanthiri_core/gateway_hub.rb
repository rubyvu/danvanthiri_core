module DanvanthiriCore
  class GatewayHub
    def self.send(number, message)
      api_key = ENV["sms_api"]
      url = "http://login.smsgatewayhub.com/api/mt/SendSMS"
      number.slice!(0) if number[0]=='+'
      params={
        APIKey: ENV["sms_api"],
        senderid: "DANVTH",
        channel: 2,
        DCS: 0,
        flashsms: 0,
        number: number,
        text: message 
      }
      begin
        raw = RestClient.post url, params
        result = JSON.parse raw
        if result["ErrorCode"]=="000"
          result = {code: "SUCCESS", message: "OTP is sent to #{number}"}
        else
          result = {code: "ERR", errors: [result["ErrorMessage"]]}
        end
      rescue Exception => e
        Rails.logger.error(ex.inspect)
        result = {code: "ERR", errors: [ex.message]}
      end
      result
    end
  end
end