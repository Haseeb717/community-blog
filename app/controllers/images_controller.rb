class ImagesController < ApplicationController
  before_action :set_image, only: [:destroy,]

  

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = "Image Successfully deleted"
        redirect_to :back
      end
      format.json do
        render json: 'success'
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params[:image]
    end
end
