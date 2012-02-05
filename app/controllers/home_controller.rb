class HomeController < ApplicationController
  def index
    @featured_city_0 = Organization.find_by_slug("hermon-me")
    @featured_city_1 = Organization.find_by_slug("mount-desert-me")
    @featured_city_2 = Organization.find_by_slug("watertown-ma")

    @example_city_0 = Organization.find_by_slug("union-ct")
    @example_city_1 = Organization.find_by_slug("salisbury-nh")
    @example_city_2 = Organization.find_by_slug("hermon-me")
    @example_city_3 = Organization.find_by_slug("belmont-ma")
    @example_city_4 = Organization.find_by_slug("waltham-ma")
    @example_city_5 = Organization.find_by_slug("boston-ma")
  end

  def about
  end

  def price
  end

  def share
    @organization = Organization.find(params[:id])
  end

  def contact
  end
end
