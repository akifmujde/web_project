class ApplicationController < ActionController::Base
  before_action :set_locale 
  before_action :configure_permitted_parameters, if: :devise_controller? 
  
  def set_locale
    I18n.locale=params[:locale] || I18n.default_locale  
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:name,:surname,:image])
      devise_parameter_sanitizer.permit(:account_update,keys:[:name,:surname,:image])
    end
end
