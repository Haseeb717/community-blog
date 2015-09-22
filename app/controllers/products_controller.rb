class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy,:product_comments]

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
    @product.images.build
    respond_with(@product)
  end

  def edit

  end

  def create
    @product = Product.new(product_params)
    @product.save
    respond_with(@product)
  end

  def update
    @product.update(product_params)
    respond_with(@product)
  end

  def destroy
    @product.destroy
    respond_with(@product)
  end

  def product_comments
    comment = Comment.new(comment_params)
    comment.save
    @product.comments << comment
    respond_with(@product)
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title,:description,:pros,:cons,:price,:link, images_attributes: [:avatar])
    end

    def comment_params
      params.require(:product).require(:comments_attributes).require("0").permit(:description)
    end
end
