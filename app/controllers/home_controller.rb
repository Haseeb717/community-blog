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

      @type = "product"
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
    @products = @user.products.all.order('created_at DESC').page(params[:page]).per(3)
    @categories = @user.products.joins(:categories).uniq.pluck(:name)
    @tags = @user.products.joins(:tags).uniq.pluck(:name)
    
    if @user.followers(User).count > 0 
      @followers = @user.followers(User)
    end

  end 

  def search
    
    @solr_search = true
    if params["type"] == "user"
      respond_to do |format|
        format.html { redirect_to home_user_path(search: params[:search]) }
      end
      

    elsif params["type"] == "product"
      @search = Sunspot.search(Product) do
        fulltext params[:search]
        paginate(:page => params[:page] || 1, :per_page => 3)
      end
      @products = @search.results
      @type = "product"

    elsif params["type"] == "category"
      @search = Sunspot.search(Category) do
        fulltext params[:search]
        paginate(:page => params[:page] || 1, :per_page => 3)
      end
      @products = Array.new
      @search.results.each do |result|
        @products += result.products
      end
      @type = "category"

    elsif params["type"] == "hashtag"
      @search = Sunspot.search(Tag) do 
        fulltext params[:search]
        paginate(:page => params[:page] || 1, :per_page => 3)
      end
      @products = Array.new
      @search.results.each do |result|
        @products += result.products
      end
      @type = "hashtag"
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
    flag = user.ratings.where(:user_from=>current_user.id)
    if flag.empty?
      rating = Rating.create(:rate=>rating_val,:user_from=>current_user.id)
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
    else
      render :json => {:message => 'error'}
    end
  end

  def user_sorted_products
    if !params["rate_val"].empty?
      @products = Product.joins(:user).order("total_rating DESC")
    else
      @products = Product.joins(:user).order("total_rating")
    end
    @solr_search = false
  end

  def like_sorted_search_products
    if !params["rate_val"].empty?
      @products =   Product.order("total_likes DESC")
    else
      @products = Product.order("total_likes")
    end
  end

  def like_sorted_products
    user = User.find(params["user_id"])
    if !params["rate_val"].empty?
      @products = user.products.order("total_likes DESC").page(params[:page]).per(3)
    else
      @products = user.products.order("total_likes").page(params[:page]).per(3)
    end
    
    
  end
end
