class FriendshipsController < ApplicationController

  def create
    @user = User.find(params[:friended_id])
    current_user.add_friend(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Friendship.find(params[:id]).friended ||
            Friendship.find(params[:id]).friender
    current_user.unfriend(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

end
