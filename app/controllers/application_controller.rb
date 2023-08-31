class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    items_path
  end
  

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name_kana])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name_kana])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:postal_code])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:address])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:telephone_number])
  end
end
