require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    url = "https://api.darksky.net/forecast/5b39a76b5893e01d5535a562ee0f0fbc/" << @lat << "," << @lng
    @parsed_data = JSON.parse(open(url).read)


    @current_temperature =           @parsed_data["currently"]["temperature"]
    @current_summary =               @parsed_data["currently"]["summary"]
    @summary_of_next_sixty_minutes = @parsed_data["minutely"]["summary"]
    @summary_of_next_several_hours = @parsed_data["hourly"]["summary"]
    @summary_of_next_several_days =  @parsed_data["daily"]["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end
