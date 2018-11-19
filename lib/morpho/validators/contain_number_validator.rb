# frozen_string_literal: true

module Morpho
  module Validators
    class ContainNumberValidator < ActiveModel::EachValidator
      NUMBER_FORMAT = /\A(?=.*\d)/x

      def validate_each(record, attribute, value)
        unless value =~ self.class::NUMBER_FORMAT
          record.errors.add(
            attribute,
            options[:message] ||
            I18n.t('morpho.labels.validators.contain_number')
          )
        end
      end
    end
  end
end
