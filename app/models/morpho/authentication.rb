# frozen_string_literal: true

module Morpho
  class Authentication < ApplicationRecord
    belongs_to :user
  end
end
