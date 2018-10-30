module Morpho
  class User::Contract::Activate < Reform::Form
    include Reform::Form::ActiveRecord

    property :email
    validates :email, presence: true, email_format: true
  end
end
