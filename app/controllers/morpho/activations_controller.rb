module Morpho
  class ActivationsController < ApplicationController
    skip_before_action :require_login, only: [ :new, :create, :show ]
    helper_method :user

    def create
      if user && !user.active?
        user.setup_activation
        send_activation_needed_email!
        flash.now[:notice] = I18n.t('morpho.messages.activations.create.success')
        render :new
      else
        flash.now[:error] = I18n.t('morpho.messages.activations.create.failure')
        render :new
      end
    end

    def show
      if user && !user.active?
        user.activate!
        redirect_to sign_in_path, success: I18n.t('morpho.messages.activations.activate.success')
      else
        redirect_to sign_in_path, error: I18n.t('morpho.messages.activations.activate.failure')
      end
    end

    protected

    def user
      @user ||= case
      when %w(show).include?(action_name)
        Morpho::User.load_from_activation_token(params[:token])
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
