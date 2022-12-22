require 'grape-swagger'
module AddressApi
  class Api < Grape::API

    mount AddressApi::V1::OrderApi
    add_swagger_documentation
  end
end


