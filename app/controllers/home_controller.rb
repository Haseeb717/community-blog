class HomeController < ApplicationController

  def index
    @products = Product.all.order('created_at DESC')
  end
  
  def profile
    @products = Product.all
    @categories = Category.all
  end 
end
