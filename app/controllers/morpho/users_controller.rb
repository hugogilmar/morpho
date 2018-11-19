# frozen_string_literal: true

module Morpho
  class UsersController < ApplicationController
    skip_before_action :require_login, only: [ :new, :create ]
    helper_method :user

    def create
      if user.update_attributes(user_params)
        redirect_to sign_in_path, success: I18n.t('morpho.messages.users.create.success')
      else
        flash.now[:alert] = I18n.t('morpho.messages.users.create.failure')
        render :new
      end
    end

    protected

    def user
      @user ||= Morpho::User.new
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end
