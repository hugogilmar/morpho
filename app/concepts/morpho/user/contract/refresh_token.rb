module Morpho
  class User::Contract::RefreshToken < Reform::Form
    include Reform::Form::ActiveRecord

    property :refresh_token
    validates :refresh_token, presence: true
  end
end
