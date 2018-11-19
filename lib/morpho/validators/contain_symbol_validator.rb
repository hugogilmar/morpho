# frozen_string_literal: true

module Morpho
  module Validators
    class ContainSymbolValidator < ActiveModel::EachValidator
      SYMBOL_FORMAT = /\A(?=.*[[:^alnum:]])/x

      def validate_each(record, attribute, value)
        unless value =~ self.class::SYMBOL_FORMAT
          record.errors.add(
            attribute,
            options[:message] ||
            I18n.t('morpho.labels.validators.contain_symbol')
          )
        end
      end
    end
  end
end
