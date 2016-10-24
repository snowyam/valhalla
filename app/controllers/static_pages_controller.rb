class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    if user_signed_in?
      @post       = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @comment    = current_user.comments.build
    end
  end

  def help
  end

  def about
  end

  def license
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
