require 'grape-swagger'

module Morpho
  class API < Grape::API
    format :json
    rescue_from :all

    mount Morpho::Resources::Tokens
    mount Morpho::Resources::Users

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
