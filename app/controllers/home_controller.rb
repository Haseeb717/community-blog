class HomeController < ApplicationController

  def index
    @products = Product.all.order('created_at DESC').page(params[:page]).per(5)
  end
  
  def profile
    @user = User.find(params["id"])
    if !@user.products.empty?
      @featured_products = @user.products.where(:feature=>true)

      # if(!@featured_product)
      #   @featured_product = current_user.products.first.update_attributes() 
      # end
    end
    # @featured_products = Product.where(:feature=>true) 
    @products = @user.products.all.order('created_at DESC').page(params[:page]).per(5)
    @categories = Category.all
  end 

  def search

    if params["type"] == "user"
      @search = Sunspot.search(User) do |s|
        s.fulltext params[:search]
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

    else
      @message = true    
  end

end
