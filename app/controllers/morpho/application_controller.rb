module Morpho
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    add_flash_types :notice, :alert, :error, :success
    layout 'morpho/application'
    before_action :require_login

    protected

    def not_authenticated
      redirect_to sign_in_path, notice: I18n.t('morpho.messages.unauthenticated')
    end
  end
end
