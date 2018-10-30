module Morpho
  class User::Contract::SignIn < Reform::Form
    include Reform::Form::ActiveRecord

    property :email
    validates :email, presence: true, email_format: true
    property :password
    validates :password, presence: true
  end
end
