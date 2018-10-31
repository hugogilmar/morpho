module Morpho
  class User::Contract::ExternalSignIn < Reform::Form
    include Reform::Form::ActiveRecord

    property :email
    validates :email, presence: true, email_format: true
    property :uid
    validates :uid, presence: true
    property :provider
    validates :provider, presence: true
  end
end
