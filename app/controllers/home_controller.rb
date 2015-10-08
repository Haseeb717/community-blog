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
    @products = @user.products.all.order('created_at DESC').page(params[:page]).per(2)
    @categories = Category.all
    if @user.followers(User).count > 0 
      @followers = @user.followers(User)
    end
  end 

  def search

    if params["type"] == "user"
      @search = Sunspot.search(User) do 
        fulltext params[:search]
        paginate(:page => params[:page] || 1, :per_page => 3)
      end
      # @search_products = Array.new
      # @search.results.each do |result|
      #   @search_products += result.products
      # end
      @type = "user"
      redirect_to profile_path(@search.results.first)

    elsif params["type"] == "product"
      @search = Sunspot.search(Product) do
        fulltext params[:search]
        paginate(:page => params[:page] || 1, :per_page => 3)
      end
      @search_products = @search.results
      @type = "product"

    elsif params["type"] == "category"
      @search = Sunspot.search(Category) do
        fulltext params[:search]
        paginate(:page => params[:page] || 1, :per_page => 3)
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

  def user_following
    user = User.find(params["user"])
    current_user.toggle_follow!(user)
    render :json => {:message => 'success'}
    
  end
end
