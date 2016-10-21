class UsersController < ApplicationController

  def index
    @user = current_user
    @users = @user.find_friends.where.not(confirmed_at: nil).paginate(page: params[:page], per_page: 20).order('created_at ASC')
  end

  def show
    @user = User.find(params[:id])
    @post = current_user.posts.build
    @posts = @user.posts.paginate(page: params[:page], per_page: 20)
  end

  def added_friends
    @title = "Friends"
    @user  = User.find(params[:id])
    @users = @user.friends_list.paginate(page: params[:page])
    render 'show_friends'
  end

  def friend_requests
    @title = "Friend Requests: Add them to become friends!"
    @user  = User.find(params[:id])
    @users = @user.pending_friends.paginate(page: params[:page])
    render 'show_friends'
  end

end
