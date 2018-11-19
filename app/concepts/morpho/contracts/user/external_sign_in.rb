module Morpho
  module Contracts
    module User
      class ExternalSignIn < Reform::Form
        include Reform::Form::ActiveRecord

        property :email
        property :provider
        property :uid

        validates :email, presence: true, email_format: true
        validates :provider, presence: true
        validates :uid, presence: true
      end
    end
  end
end
