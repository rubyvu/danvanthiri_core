module DanvanthiriCore
  require 'twilio-ruby'
  class TwilioSms
    def self.send(number, message)
      @client = Twilio::REST::Client.new ENV["account_sid"], ENV["auth_token"]
      sent = false
      begin
        @client.account.messages.create({
          from: ENV["number"], 
          to: number, 
          body: message  
        })
        sent = true
      rescue Exception => ex
        Rails.logger.error(ex.inspect)
        sent = false
      end
      sent
    end
  end
end