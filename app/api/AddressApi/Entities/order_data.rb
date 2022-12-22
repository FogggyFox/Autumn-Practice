# frozen_string_literal: true

require 'grape-swagger-entity'
module AddressApi
  module Entities
    class OrderData < Grape::Entity
      expose :order do
        expose :id, documentation: { type: Integer, desc: 'Order ID' }
        expose :name, documentation: { type: String, desc: 'Name of client' }
        expose :raw_address, documentation: { type: String, desc: 'Raw address' }
        expose :address_kladr, documentation: { type: String, desc: 'Kladr address' }
        expose :price, documentation: { type: BigDecimal, desc: 'Price of order' }
        expose :status, documentation: { type: String, desc: 'Status of order' }
      end
    end
  end
end
