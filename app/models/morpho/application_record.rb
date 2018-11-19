# frozen_string_literal: true

module Morpho
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
