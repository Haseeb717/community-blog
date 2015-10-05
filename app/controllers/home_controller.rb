class HomeController < ApplicationController

  def index
    @products = Product.all.order('created_at DESC')
  end
  
  def profile
    @featured_products = Product.where(:feature=>true) 
    @products = Product.all
    @categories = Category.all
  end 
end
