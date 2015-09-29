class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy,:product_comments,:product_likes_and_dislikes]

  respond_to :html

  def index
    @products = Product.all
    respond_with(@products)
  end

  def show
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
        format.html { render action: "show", notice: 'Comment not added. Try Again' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def product_likes_and_dislikes
    current_user.like!(@product)
    type = params["type"]
    update = Like.where(:liker_id=>current_user.id , :likeable_id=>@product.id)
    if type=="Like"
      update.first.update_attributes(:flag=>true)
    else
      update.first.update_attributes(:flag=>false)
    end

    render :json => {:message => 'success'}
  end

  def product_categories
    category = Category.where("name like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.html
      format.json { render :json => category.map(&:attributes) }
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title,:description,:pros,:cons,:price,:link,:abc, images_attributes: [:avatar])
    end

    def comment_params
      params.require(:product).require(:comments_attributes).require("0").permit(:description)
    end
end
