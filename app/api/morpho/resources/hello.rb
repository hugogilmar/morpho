module Morpho
  module Resources
    class Hello < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses, Morpho::Helpers::JWTUtils

      namespace :hello do
        desc 'Request hello message' do
          success Morpho::Grape::DataWrapper.new(Morpho::Entities::Message)
        end
        get :public do
          message = { content: 'Hello world!' }

          present message, with: Morpho::Entities::Message
        end

        namespace do
          before do
            require_login
          end

          desc 'Request hello message' do
            success Morpho::Grape::DataWrapper.new(Morpho::Entities::Message)
            failure [
              [ 401, I18n.t('morpho.api.messages.unauthorized'), Morpho::Entities::Error ]
            ]
          end
          get :private do
            message = { content: 'Hello world!' }

            present message, with: Morpho::Entities::Message
          end
        end
      end
    end
  end
end
