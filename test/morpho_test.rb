# frozen_string_literal: true

require 'test_helper'

class Morpho::Test < ActiveSupport::TestCase
  test 'truth' do
    assert_kind_of Module, Morpho
  end
end
