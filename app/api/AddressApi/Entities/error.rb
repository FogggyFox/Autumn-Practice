require 'grape-swagger-entity'
module AddressApi
  module Entities
    class Error < Grape::Entity
      expose :code
      expose :text
    end
  end
end

