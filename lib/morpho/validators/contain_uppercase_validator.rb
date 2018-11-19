# frozen_string_literal: true

module Morpho
  module Validators
    class ContainUppercaseValidator < ActiveModel::EachValidator
      UPPERCASE_FORMAT = /\A(?=.*[A-Z])/x

      def validate_each(record, attribute, value)
        unless value =~ self.class::UPPERCASE_FORMAT
          record.errors.add(
            attribute,
            options[:message] ||
            I18n.t('morpho.labels.validators.contain_uppercase')
          )
        end
      end
    end
  end
end
