module Morpho
  class API < ::Grape::API
    format :json

    error_formatter :json, Morpho::Formatters::StandardError

    rescue_from Morpho::Exceptions::StandardError do |e|
      message = Morpho::Entities::Error.represent(e)
      error!(message, e.status)
    end

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
