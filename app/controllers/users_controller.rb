class UsersController < ApplicationController

  def index
    @users = User.where.not(confirmed_at: nil).paginate(page: params[:page], per_page: 20).order('created_at ASC')
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 20)
  end

end
