class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitterd_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_kana_name, :first_kana_name, :postal_code, :prefecture, :city, :building, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end

  def after_sign_in_for(resource)
    items_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
