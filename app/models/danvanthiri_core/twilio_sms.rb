module DanvanthiriCore
  require 'twilio-ruby'
  class TwilioSms
    def self.send(number, message)
      @client = Twilio::REST::Client.new ENV["account_sid"], ENV["auth_token"]
      result = {}
      begin
        @client.account.messages.create({
          from: ENV["number"], 
          to: number, 
          body: message  
        })
        result = {code: "SUCCESS", message: "otp was sent to #{format(number)}"}
      rescue Exception => ex
        Rails.logger.error(ex.inspect)
        result = {errors: [ex.message]}
      end
      result
    end

    def self.format_number(number)
      number.slice!(0) if number[0]=='0' 
      number = "+91#{number}"
    end
  end
end