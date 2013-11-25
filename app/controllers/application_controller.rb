class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :define_language

  def define_language

    lang = params[:lang]
    if lag.blank?
      lang = cookies[:lang]
        if  lang.blank?
          unless request.headers['HTTP_ACCEPT_LANGUAGE'].blank?
            lang = request.headers['HTTP_ACCEPT_LANGUAGE'][0..1]
            unless %w(ru en).include? lang
                lang =nil
            end
          end
        end
    end

    unless lang.blank?
      I18n.locale = lang
      cookies[:lang] = {value: lang, expires_in: 3.month}
    end
    end



end
