Rails.application.routes.draw do
  mount Morpho::Engine => '/'
  mount Morpho::API => '/api', as: :api
end
