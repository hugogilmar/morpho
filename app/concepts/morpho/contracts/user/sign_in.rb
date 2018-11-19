# frozen_string_literal: true

module Morpho
  module Contracts
    module User
      class SignIn < Reform::Form
        include Reform::Form::ActiveRecord

        property :email
        property :password

        validates :email, presence: true, email_format: true
        validates :password, presence: true
      end
    end
  end
end
