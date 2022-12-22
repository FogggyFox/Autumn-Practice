# frozen_string_literal: true

require 'net/http'
module AddressApi
  module V1
    class OrderApi < Grape::API
      version 'v1', using: :path
      format :json
      content_type :json, 'application/json'
      default_format :json
      prefix :api

      rescue_from RangeError, TypeError, ActiveRecord::RecordInvalid do |e|
        error!({
                 code: 400,
                 text: e.message
               })
      end
      rescue_from NoMethodError, ArgumentError do |e|
        error!({
                 code: 422,
                 text: e.message
               })
      end
      rescue_from :all do |e|
        error!({
                 code: e.status,
                 text: e.message
               })
      end

      resource :orders do
        desc 'Return all info.', entity: AddressApi::Entities::OrderData
        get  do
          orders = Order.all
          present orders, with: AddressApi::Entities::OrderData
        end

        desc 'Return info with id.', entity: AddressApi::Entities::OrderData
        params do
          requires :id, type: Integer, desc: 'Order ID'
        end
        route_param :id do
          get do
            order = Order.find(params[:id])
            present order, with: AddressApi::Entities::OrderData
          end
        end

        desc 'Create an order.', entity: AddressApi::Entities::OrderData
        params do
          requires :name
          requires :raw_address, documentation: { in: 'body' }
          requires :price, type: BigDecimal
        end
        post do
          order = Order.create!({
                                  name: params[:name],
                                  raw_address: params[:raw_address],
                                  price: params[:price],
                                  address_kladr: Services::ApiService.get_kladr(params[:raw_address])
                                })
          order.update!(status: 'opened')
          present order, with: AddressApi::Entities::OrderData
        end

        #         desc 'Delete order.', entity: AddressApi::Entities::OrderData
        #         params do
        #           requires :id_first, type: Integer, desc: 'Delete from this id'
        #           requires :id_second, type: Integer, desc: 'Delete to this id'
        #         end
        #         delete do
        #           (params[:id_first]..params[:id_second]).each { |id|
        #             order = Order.find(id)
        #             order.destroy
        #           }
        #           orders = Order.all
        #           present orders, with: AddressApi::Entities::OrderData
        #         end
      end
    end
  end
end
