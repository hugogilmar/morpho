module Morpho
  class User < ApplicationRecord
    authenticates_with_sorcery!

    has_many :authentications, dependent: :destroy
    accepts_nested_attributes_for :authentications

    validates :email, uniqueness: true
    validates_email_format_of :email

    def active?
      self.activation_state == 'active'
    end

    def resend_activation_needed_email!
      self.setup_activation
      self.reload
      self.send_activation_needed_email!
    end

    def resend_unlock_token_email!
      self.login_lock!
    end

    class << self
      # bugfix: https://github.com/Sorcery/sorcery/issues/146
      def create_and_validate_from_provider(provider, uid, attrs)
        user = new(attrs)

        user.send(sorcery_config.authentications_class.name.demodulize.underscore.pluralize).build(
          sorcery_config.provider_uid_attribute_name => uid,
          sorcery_config.provider_attribute_name => provider
        )

        saved = user.sorcery_adapter.save
        [user, saved]
      end
    end

    # bugfix: https://github.com/Sorcery/sorcery/issues/146
    def add_provider_to_user(provider, uid)
      authentications = sorcery_config.authentications_class.name.demodulize.underscore.pluralize

      if sorcery_adapter.find_authentication_by_oauth_credentials(authentications, provider, uid).nil?
        user = send(authentications).build(
          sorcery_config.provider_uid_attribute_name => uid,
          sorcery_config.provider_attribute_name => provider
        )

        user.sorcery_adapter.save(validate: false)
      else
        user = false
      end

      user
    end
  end
end
