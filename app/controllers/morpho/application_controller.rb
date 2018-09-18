module Morpho
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    layout 'morpho/application'
  end
end
