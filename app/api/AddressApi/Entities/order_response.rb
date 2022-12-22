require_relative 'order_data'
require 'grape-swagger-entity'
module AddressApi
  module Entities
    class OrderResponse < Grape::Entity
      expose :orders, using: AddressApi::Entities::OrderData
    end
  end

end

