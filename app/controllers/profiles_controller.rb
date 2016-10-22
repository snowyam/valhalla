class ProfilesController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @user = current_user
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(user_params)
      flash[:success] = "Profile updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:profile).permit(:bio, :birthday, :birthplace,
                                   :currentplace, :education, :occupation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user == @user
    end

end
