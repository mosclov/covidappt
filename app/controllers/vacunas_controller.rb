class VacunasController < ApplicationController

  def scrape
  url = 'https://epicproxy.et0502.epichosted.com/ucsd/SignupAndSchedule/EmbeddedSchedule?dept=9990995&id=99909951,99909952,99909953,99909954,99909955,99909956&vt=3550&view=plain&payor=-3'
  response = URI(url)
  1/0
  if response[:status] == :completed && response[:error].nil?
    flash.now[:notice] = "Successfully scraped url"
  else
    flash.now[:alert] = response[:error]
  end
  rescue StandardError => e
  flash.now[:alert] = "Error: #{e}"
  end
end
