class HomeController < ApplicationController

  def index
    @products = Product.all.order('created_at DESC')
  end
  
end
