module Morpho
  module Contracts
    module User
      class DeliverEmail < Reform::Form
        include Reform::Form::ActiveRecord

        property :email

        validates :email, presence: true, email_format: true
      end
    end
  end
end
