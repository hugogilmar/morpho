require 'reform/form/validation/unique_validator'

module Morpho
  class User::Contract::SignUp < Reform::Form
    include Reform::Form::ActiveRecord

    property :email
    property :password
    property :password_confirmation, virtual: true
    validates :email, presence: true, unique: true, email_format: true
    validates :password,
              presence: true,
              confirmation: true,
              length: { minimum: Morpho.config.auth.password_minimum_length },
              # rubocop:disable Style/HashSyntax
              :'morpho/validators/contain_number' => true,
              :'morpho/validators/contain_uppercase' => true,
              :'morpho/validators/contain_symbol' => true
    # rubocop:enable Style/HashSyntax
    validates :password_confirmation, presence: true
  end
end
