module Morpho
  class UserMailer < ApplicationMailer
    def activation_needed_email(user)
      @user = user
      @url = activate_url(token: @user.activation_token)

      mail(to: @user.email, subject: 'You have successfully signed up')
    end

    def activation_success_email(user)
      @user = user
      @url = sign_in_url()

      mail(to: @user.email, subject: 'Your account is now activated')
    end

    def reset_password_email(user)
      @user = user
      @url = new_password_url(token: @user.reset_password_token)

      mail(to: @user.email, subject: 'You have requested to reset your password')
    end

    def unlock_token_email(user)
    end
  end
end
