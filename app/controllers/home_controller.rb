class HomeController < ApplicationController

  def index
    @products = Product.all.order('created_at DESC').page(params[:page]).per(5)
    respond_to do |format|
      format.html
      format.js 
    end
  end
  
  def profile
    @user = User.find(params["id"])
    if !@user.products.empty?
      @featured_products = @user.products.where(:feature=>true)
      @type = "user"
      # if(!@featured_product)
      #   @featured_product = current_user.products.first.update_attributes() 
      # end
    end
    count = 0
    rate = 0
    @ratings = 0
    @user.ratings.each do |rating|
      rate = rate + rating.rate
      count = count + 1
    end
    if @user.ratings.count > 0
      rate = rate/count
      @ratings = rate.round
    end 
    
    # @featured_products = Product.where(:feature=>true) 
    @products = @user.products.all.order('created_at DESC').page(params[:page]).per(1)
    @categories = Category.all
    if @user.followers(User).count > 0 
      @followers = @user.followers(User)
    end

  end 

  def search
    if params["type"] == "user"
      respond_to do |format|
        format.html { redirect_to home_user_path(search: params[:search]) }
      end
      

    elsif params["type"] == "product"
      @search = Sunspot.search(Product) do
        fulltext params[:search]
        paginate(:page => params[:page] || 1, :per_page => 2)
      end
      @products = @search.results
      @type = "product"

    elsif params["type"] == "category"
      @search = Sunspot.search(Category) do
        fulltext params[:search]
        paginate(:page => params[:page] || 1, :per_page => 2)
      end
      @products = Array.new
      @search.results.each do |result|
        @products += result.products
      end
      @type = "category"

    # elsif params["type"] == "hashtag"
    #   @search_products = Array.new
    #   @type = "hashtag"
    else
      
    end
  end

  def user_following
    user = User.find(params["user"])
    current_user.toggle_follow!(user)
    render :json => {:message => 'success'}
  end

  def user_list
    @search = Sunspot.search(User) do 
      fulltext params[:search]
      paginate(:page => params[:page] || 1, :per_page => 15)
    end
    @type = "user"
    @products = @search.results
  end

  def user_ratings
    rating_val = params["rating_val"]
    user = User.find(params["user"])
    rating = Rating.create(:rate=>rating_val)
    user.ratings << rating
    count = 0
    rate = 0
    ratings = 0
    
    user.ratings.each do |rating|
      rate = rate + rating.rate
      count = count + 1
    end
    if user.ratings.count > 0
      rate = rate/count
      ratings = rate.round
      user.update_attributes(:total_rating=>ratings)
    end 
    render :json => {:message => 'success',:rate=>ratings}
  end

  def user_sorted_products
    rating_val = params["rate_val"]
    @products = Product.joins(:user).where("total_rating > ?", rating_val).order("total_rating DESC")
   
  end
end
