# frozen_string_literal: true

require 'reform/form/validation/unique_validator'

module Morpho
  module Contracts
    module User
      class SignUp < Reform::Form
        include Reform::Form::ActiveRecord

        property :email
        property :password
        property :password_confirmation, virtual: true

        validates :email, presence: true, unique: true, email_format: true
        validates :password,
                  presence: true,
                  confirmation: true,
                  length: { minimum: Morpho.config.auth.password_minimum_length },
                  :'morpho/validators/contain_number' => true,
                  :'morpho/validators/contain_uppercase' => true,
                  :'morpho/validators/contain_symbol' => true
        validates :password_confirmation, presence: true
      end
    end
  end
end
