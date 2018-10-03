module Morpho
  class UserMailer < ApplicationMailer
    def activation_needed_email(user)
      @user = user
      @url = activate_url(token: @user.activation_token)

      mail(to: @user.email, subject: t('morpho.mailer.activation_needed.subject'))
    end

    def activation_success_email(user)
      @user = user
      @url = sign_in_url()

      mail(to: @user.email, subject: t('morpho.mailer.activation_success.subject'))
    end

    def reset_password_email(user)
      @user = user
      @url = new_password_url(token: @user.reset_password_token)

      mail(to: @user.email, subject: t('morpho.mailer.reset_password.subject'))
    end

    def unlock_token_email(user)
      @user = user
      @url = unlock_url(token: @user.unlock_token)

      mail(to: @user.email, subject: t('morpho.mailer.unlock_token.subject'))
    end
  end
end
