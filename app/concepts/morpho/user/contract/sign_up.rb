require 'reform/form/validation/unique_validator'

module Morpho
  class User::Contract::SignUp < Reform::Form
    include Reform::Form::ActiveRecord

    property :email
    property :password
    property :password_confirmation, virtual: true
    validates :password_confirmation, presence: true
  end
end
