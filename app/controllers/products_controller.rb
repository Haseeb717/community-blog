class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy,:product_comments,:product_likes_and_dislikes]

  respond_to :html

  def index
    @products = current_user.products.all
    respond_with(@products)
  end

  def show
    @products = Product.all
    respond_with(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def edit

  end

  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        current_user.products << @product
        format.html { redirect_to @product, notice: 'Product created successfully' }
        format.json { render json:  @product, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product updated successfully' }
        format.json { render json:  @product, status: :created, location: @company }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_with(@product)
  end

  def product_comments
    comment = Comment.new(comment_params)
    respond_to do |format|
      if comment.save
        @product.comments << comment
        current_user.comments << comment
        format.html { redirect_to @product, notice: 'Comment added successfully' }
        format.json { render json:  @product, status: :created, location: @company }
      else
        format.html { redirect_to @product, alert: 'Empty Comment not added. Try Again' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def product_likes_and_dislikes
    type = params["type"]
    if type=="like"
      current_user.like!(@product)
      @product.update_attributes(:total_likes=>@product.likers(User).count)
    else
      current_user.unlike!(@product)
    end
    count  = @product.likers(User).count
    @product.update_attributes(:total_likes=>@product.likers(User).count)
    render :json => {:message => 'success',:count=>count}
  end

  def product_categories
    category = Category.where("name like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.html
      format.json { render :json => category.map(&:attributes) }
    end
  end

  def update_featured
    # false all featured products
    f_product = current_user.products.where(:feature=>true)
    if !f_product.empty?
      f_product.first.update_attributes(:feature=>false)
    end

    # update product to featured
    product = Product.find(params[:id])
    if product.update_attributes(:feature=>true)
      render :json => {:message => 'success'}
    else
      render :json => {:message => 'error'}
    end
  end

  def delete_product_images
    @product = Product.find(params[:id])
    images = params[:ids]
    flag = true
    images.each do |image|
      img = Image.find(image)
      if !img.destroy
        flag = false
      end
    end
  end

  private
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title,:description,:pros,:cons,:price,:link,:abc,:def,images_attributes: [:avatar])
    end

    def comment_params
      params.require(:product).require(:comments_attributes).require("0").permit(:description)
    end
end
