module Morpho
  class SessionsController < ApplicationController
    skip_before_action :require_login, only: [ :new, :create ]

    def create
      if login(session_params[:email], session_params[:password], session_params[:remember_me])
        redirect_to root_path, success: I18n.t('morpho.messages.sessions.create.success') and return
      else
        flash.now[:error] = I18n.t('morpho.messages.sessions.create.failure')
        render :new
      end
    end

    def destroy
      redirect_to sign_in_path, success: I18n.t('morpho.messages.sessions.destroy.success') and return if logout
    end

    protected

    def session_params
      params.require(:session).permit(:email, :password, :remember_me)
    end
  end
end
