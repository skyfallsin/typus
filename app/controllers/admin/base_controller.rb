class Admin::BaseController < ActionController::Base

  include Typus::Authentication::const_get(Typus.authentication.to_s.classify)

  before_filter :set_models_constantized
  before_filter :reload_config_and_roles
  before_filter :authenticate
  before_filter :set_locale

  helper_method :admin_user

  def user_guide
  end

  protected

  def reload_config_and_roles
    Typus.reload! unless Rails.env.production?
  end

  def set_path
    @back_to || request.referer || admin_dashboard_path
  end

  def set_locale
    I18n.locale = admin_user.locale
  end

  def set_models_constantized
    Typus::Configuration.models_constantized!
  end

end
