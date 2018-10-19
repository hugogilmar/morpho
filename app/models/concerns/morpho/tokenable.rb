module Morpho
  module Tokenable
    extend ActiveSupport::Concern

    included do
      before_create :generate_refresh_token
    end

    def generate_refresh_token!
      self.generate_refresh_token
      self.save
    end

    protected

    def generate_refresh_token
      self.refresh_token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless self.class.exists?(refresh_token: random_token)
      end
    end
  end
end
