require "sms/version"
require 'twilio-ruby'

class SMS

  INSTANCE = SMS.new

  class << self
    def method_missing(m, *args, &blk)
      INSTANCE.send(m, *args, &blk)
    end
  end

  attr_writer :twilio_account_id, :twilio_auth_token, :default_recipients, :twilio_from

  def client
    @client ||= begin
      setup!
      Twilio::REST::Client.new(twilio_account_id, twilio_auth_token)
    end
  end

  def default_recipients
    @twilio_from ||= ENV['TWILIO_RECIPIENTS']
  end

  def twilio_from
    @twilio_from ||= ENV['TWILIO_FROM']
  end

  def twilio_account_id
    @twilio_account_id ||= ENV['TWILIO_ACCOUNT_ID']
  end

  def twilio_auth_token
    @twilio_auth_token ||= ENV['TWILIO_AUTH_TOKEN']
  end

  def message(messages, *more)
    opts = more.last.is_a?(Hash) ? more.pop : nil
    recipients = opts && (opts[:recipients] || opts[:recipient]) || more.first || default_recipients
    raise "You must set a recipient. Please put your recipient number" +
      " in the environment variable as TWILIO_RECIPIENTS or set it with SMS.default_recipients= or " +
      " as it as an option to your #message call." unless recipients
    recipients = Array(recipients)
    recipients.map! { |r| r.to_s }
    from = opts && opts[:from] || twilio_from
    raise "You must set a twlio from number. Please put your from number" +
      " in the environment variable as TWILIO_FROM or set it with SMS.from=" unless from
    messages = Array(messages)
    messages.map! { |m| m.to_s }
    messages.each do |message|
      message_parameters = { :body => message }
      recipients.each do |recipient|
        message_parameters[:to] = recipient
        message_parameters[:from] = from
        client.account.sms.messages.create(message_parameters)
      end
    end
  end

  private
    def setup!
    !twilio_account_id.nil? or raise "You must set a twlio account id. Please put your account id" +
      " in the environment variable as TWILIO_ACCOUNT_ID or set it with SMS.twilio_account_id="
    !twilio_auth_token.nil? or raise "You must set a twlio auth token. Please put your auth token" +
      " in the environment variable as TWILIO_AUTH_TOKEN or set it with SMS.twilio_auth_token="
  end
end

module Kernel
  def sms(message, recipients = nil)
    SMS::INSTANCE.message(message, recipients)
  end
end