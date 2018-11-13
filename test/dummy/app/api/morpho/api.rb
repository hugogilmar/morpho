module Morpho
  class API < ::Grape::API
    format :json

    rescue_from Morpho::Exceptions::GeneralError, Morpho::Exceptions::EntityError  do |e|
      error!({ errors: e.present }, e.status_code)
    end

    # rescue_from :all

    mount Morpho::Resources::Users
    mount Morpho::Resources::Externals
    mount Morpho::Resources::Tokens
    mount Morpho::Resources::Passwords
    mount Morpho::Resources::Unlocks
    mount Morpho::Resources::Activations

    mount Morpho::Resources::Hello

    add_swagger_documentation({
      info: {
        title: Morpho.config.api.title,
        description: Morpho.config.api.description,
        models: Morpho.config.api.entities
      }
    })

    route :any, '*path' do
      error!({ message: I18n.t('morpho.api.messages.not_found') }, 404)
    end
  end
end
