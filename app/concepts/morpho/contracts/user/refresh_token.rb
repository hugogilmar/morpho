# frozen_string_literal: true

module Morpho
  module Contracts
    module User
      class RefreshToken < Reform::Form
        include Reform::Form::ActiveRecord

        property :refresh_token

        validates :refresh_token, presence: true
      end
    end
  end
end
