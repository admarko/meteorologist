require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    @street_address_without_spaces = @street_address.gsub(' ','+')
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=" << @street_address_without_spaces << "&sensor=false"
    @parsed_data = JSON.parse(open(url).read)
    @latitude = @parsed_data["results"][0]["geometry"]["location"]["lat"].to_s
    @longitude = @parsed_data["results"][0]["geometry"]["location"]["lng"].to_s

    url = "https://api.darksky.net/forecast/5b39a76b5893e01d5535a562ee0f0fbc/" << @latitude << "," << @longitude
    @parsed_data = JSON.parse(open(url).read)

    @current_temperature =           @parsed_data["currently"]["temperature"]
    @current_summary =               @parsed_data["currently"]["summary"]
    @summary_of_next_sixty_minutes = @parsed_data["minutely"]["summary"]
    @summary_of_next_several_hours = @parsed_data["hourly"]["summary"]
    @summary_of_next_several_days =  @parsed_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
