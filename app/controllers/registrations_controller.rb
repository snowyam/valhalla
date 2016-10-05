class RegistrationsController < Devise::RegistrationsController

  protected

    def after_sign_up_path_for(resource)
      @user
    end

    def after_update_path_for(resource)
      @user
    end

    # Extend Devise's strong parameter for forms in sign up and edit.
    def sign_up_params
      params.require(:user).permit(:first_name, :last_name,
                                   :email, :password,
                                   :password_confirmation)
    end

    def account_update_params
      params.require(:user).permit(:first_name, :last_name,
                                   :email, :password,
                                   :password_confirmation,
                                   :current_password)
    end
end