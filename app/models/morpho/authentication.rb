module Morpho
  class Authentication < ApplicationRecord
    belongs_to :user
  end
end
