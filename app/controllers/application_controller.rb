# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  helper_method :current_page
  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]
  before_filter :update_player_status

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e125a4be589f9d81263920581f6e4182'

  # raised in #current_site
  rescue_from Site::UndefinedError do |e|
    redirect_to new_site_path
  end

  def current_page
    @page ||= [1, params[:page].to_i].max
  end

  def update_player_status
    if hvz_user = current_user.try(:hvz_user)
      if hvz_user.updated_at != session[:hvz_user_updated_at]
        hvz_user.player_status.each do |key, value|
          session[key.to_sym] = value
        end
        session[:hvz_user_updated_at] = hvz_user.updated_at
      end
    end
  end

  def is_proper_creature_type(forum = nil)
    forum ||= @forum
    allowed = true if admin?
    allowed = allowed || forum.creature_type == 'all'
    allowed = allowed || session[:creature_type] == forum.creature_type
  end
  helper_method :is_proper_creature_type
  
  def must_be_proper_creature_type
    unless is_proper_creature_type
      render :text => "only #{@forum.creature_type} is allowed here"
    end
  end
  
end
