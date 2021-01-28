class Vacuna < ApplicationRecord

  def self.scrape
  url = HTTParty.get('https://epicproxy.et0502.epichosted.com/ucsd/SignupAndSchedule/EmbeddedSchedule?dept=9990995&id=99909951,99909952,99909953,99909954,99909955,99909956&vt=3550&view=plain&payor=-3')
  if url.include? "Sorry, we couldn't find any open appointments.  Please check back later."
    true
  else
    x = self.new(date: DateTime.now)
    x.save!
    self.notify
    false
  end
  end

def self.notify
    @numbers = [ENV['FEDE_PHONE']]
    @twilio_number = ENV['TWILIO_NUMBER']
    @message_body = "COVID OPEN SPOT PETCO"
    begin
      @numbers.each do |num|
      @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      @message = @client.api.account.messages.create(
        from: @twilio_number,
        to: num,
        body: @message_body,
        status_callback: 'http://e6eed770.ngrok.io' + '/twilio/status'
      )
      end
    rescue
      rescue Twilio::REST::RequestError => e
        @flash = false
        flash[:notice] = "#{e}"
        puts e
    end
  end
end
