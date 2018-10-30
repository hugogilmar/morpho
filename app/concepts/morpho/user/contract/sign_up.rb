require 'reform/form/validation/unique_validator'

module Morpho
  class User::Contract::SignUp < Reform::Form
    include Reform::Form::ActiveRecord

    property :email
    validates :email, presence: true, unique: true, email_format: true
    property :password
    validates :password, presence: true, confirmation: true
    property :password_confirmation, virtual: true
    validates :password_confirmation, presence: true
  end
end
