# frozen_string_literal: true

module Morpho
  module Operations
    module Base
      # Base delete operation
      class Delete < Morpho::Operations::Base::Find
        pass :destroy!, after: :present!

        def destroy!(options, model:, **)
          model.destroy
        end
      end
    end
  end
end
