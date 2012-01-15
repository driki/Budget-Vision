class HomeController < ApplicationController
  def index
    @example_city_0 = Organization.where(:name => "Union", :state => "CT").first
    @example_city_1 = Organization.where(:name => "Salisbury", :state => "NH").first
    @example_city_2 = Organization.where(:name => "Hermon", :state => "ME").first
    @example_city_3 = Organization.where(:name => "Belmont", :state => "MA").first
    @example_city_4 = Organization.where(:name => "Waltham", :state => "MA").first
    @example_city_5 = Organization.where(:name => "Boston", :state => "MA").first
  end

  def about
  end

  def price
  end

  def contact
  end
end
