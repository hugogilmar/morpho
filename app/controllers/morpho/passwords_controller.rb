module Morpho
  class PasswordsController < ApplicationController
    skip_before_action :require_login, only: [ :new, :create, :edit, :update ]
    helper_method :user

    def create
      if user
        user.deliver_reset_password_instructions!
        flash.now[:notice] = I18n.t('morpho.messages.passwords.create.success')
        render :new
      else
        flash.now[:error] = I18n.t('morpho.messages.passwords.create.failure')
        render :new
      end
    end

    def edit
      unless user
        flash.now[:error] = I18n.t('morpho.messages.passwords.edit.failure')
        render :new
      end
    end

    def update
      if user.update_attributes(password_params)
        user.change_password!(password_params[:password])
        redirect_to sign_in_path, success: I18n.t('morpho.messages.passwords.update.success')
      else
        flash.now[:error] = I18n.t('morpho.messages.passwords.update.failure')
        render :edit
      end
    end

    protected

    def user
      @user ||= case
      when %w(edit update).include?(action_name)
        Morpho::User.load_from_reset_password_token(params[:token])
      when %(create).include?(action_name)
        Morpho::User.find_by(email_params)
      else
        Morpho::User.new
      end

    end

    def email_params
      params.require(:user).permit(:email)
    end

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
end
