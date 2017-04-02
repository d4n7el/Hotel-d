class HomeController < ApplicationController
  def index
  	@image = Image.all
  end
end
