class HomeController < ApplicationController

  def index
    @products = Product.all.order('created_at DESC')
  end
  
  def profile
    @featured_products = Product.where(:feature=>true) 
    @products = Product.all
    @categories = Category.all
  end 

  def search

    if params["type"] == "user"
      @search = Sunspot.search(User) do
        fulltext params[:search]
        paginate :page => 2, :per_page => 1
      end
      @search_products = Array.new
      @search.results.each do |result|
        @search_products += result.products
      end
      @type = "user"

    elsif params["type"] == "product"
      @search = Sunspot.search(Product) do
        fulltext params[:search]
      end
      @search_products = @search.results
      @type = "product"

    elsif params["type"] == "category"
      @search = Sunspot.search(Category) do
        fulltext params[:search]
      end
      @search_products = Array.new
      @search.results.each do |result|
        @search_products += result.products
      end
      @type = "category"

    elsif params["type"] == "hashtag"
      @search_products = Array.new
      @type = "hashtag"
    end
      
  end

end
