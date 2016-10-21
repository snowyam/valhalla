class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @like = current_user.likes.build(post_id: params[:post_id])
    if @like.save
      flash[:success] = "Liked a post!"
    else
      flash[:danger] = "Cannot like a post more than once."
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @like = current_user.likes.find_by(post_id: params[:post_id])
    @like.destroy
    flash[:success] = "Unliked a post."
    redirect_to request.referrer || root_url
  end

end
