class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_commenter,   only: :destroy

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to request.referrer || root_url
    else
      flash[:danger] = "Could not create comment."
      redirect_to request.referrer || root_url
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment deleted!"
    redirect_to request.referrer || root_url
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def correct_commenter
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end

end
