module Morpho
  class UnlocksController < ApplicationController
    skip_before_action :require_login, only: [ :new, :create, :show ]
    helper_method :user

    def create
      if user && user.login_locked?
        user.login_lock!
        flash.now[:notice] = I18n.t('morpho.messages.unlocks.unlock.success')
        render :new
      else
        flash.now[:error] = I18n.t('morpho.messages.unlocks.unlock.failure')
        render :new
      end
    end

    def show
      if user && user.login_locked?
        user.login_unlock!
        redirect_to sign_in_path, success: I18n.t('morpho.messages.unlocks.unlock.success')
      else
        redirect_to sign_in_path, error: I18n.t('morpho.messages.unlocks.unlock.failure')
      end
    end

    protected

    def user
      @user ||= case
      when %w(show).include?(action_name)
        Morpho::User.load_from_unlock_token(params[:token])
      when %(create).include?(action_name)
        Morpho::User.find_by(email_params)
      else
        Morpho::User.new
      end

    end

    def email_params
      params.require(:user).permit(:email)
    end
  end
end
