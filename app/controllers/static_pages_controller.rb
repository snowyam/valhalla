class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
  end

  def help
  end

  def about
  end

  private

    # Show devise forms on static pages.
    helper_method :resource_name, :resource, :devise_mapping

    def resource_name
      :user
    end
   
    def resource
      @resource ||= User.new
    end
   
    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end
end
