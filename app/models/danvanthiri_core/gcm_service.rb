module DanvanthiriCore
  class GcmService
    def initialize
      @gcm = GCM.new(ENV['GCM_API_KEY'] || "AIzaSyAsIK_y4PVAe0rE3J7hpXTRCvXh9ZoEUGE")
    end

    def push_to_registration_ids(reg_ids, opts={})
      Rails.logger.debug(reg_ids.inspect)
      reg_ids = reg_ids.compact.uniq
      return false if reg_ids.blank? || opts[:data].blank?
      options = opts.merge({
        collapse_key: "swipe",
        delay_while_idle: true
      })
      Rails.logger.debug(options.inspect)
      response = @gcm.send(reg_ids, options)
      puts(response.inspect)
      response
    end

    def notify(data, reg_ids = nil)
      return if reg_ids.blank?
      options = {
        data: data
      }
      push_to_registration_ids(reg_ids, options)
    end

  end
end
