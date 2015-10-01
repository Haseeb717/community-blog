class CommentsController < InheritedResources::Base
  respond_to :html,:json
  actions :destroy,:edit,:update

  def edit
    @comment = Comment.find(params[:id])
    session[:return_to] ||= request.referer
  end

  def update
    update! { session.delete(:return_to) }
  end

  def destroy
    session[:return_to] ||= request.referer
    destroy! { session.delete(:return_to) }
  end
  
  private

    def comment_params
      params.require(:comment).permit(:description)
    end
end

