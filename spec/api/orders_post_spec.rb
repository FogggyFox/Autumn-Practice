# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  describe 'POST' do
    context 'with valid parameters' do
      let!(:my_order) { FactoryBot.build(:order) }
      let(:query) {my_order.raw_address}
      include_context 'stubbing api service'
      subject do
        post '/api/v1/orders', params:
          {
            name: my_order.name,
            raw_address: my_order.raw_address,
            price: my_order.price
          }
        Order.last
      end

      it 'saves order' do
        expect(subject.name).to eq(my_order.name)
      end

      it 'returns the address' do
        expect(subject.raw_address).to eq(my_order.raw_address)
      end

      it 'returns the price' do
        expect(subject.price).to eq(my_order.price)
      end

      it 'returns the opened status' do
        expect(subject.status).to eq('opened')
      end

      it 'returns the address_kladr' do
        expect(subject.address_kladr).not_to be_nil
      end

      it 'returns a created status' do
        subject
        expect(response).to have_http_status(:created)
      end
    end
    context 'with invalid parametres' do
      let (:query) {'Popova 36 Belgorod'}
      include_context 'stubbing api service'
      context 'with something is missing' do
        subject do
          post '/api/v1/orders', params:
            {
              name: 'string',
              price: 100
            }
          JSON.parse(response.body)
        end
        it 'code will be 400' do
          expect(subject['code']).to eq(400)
        end
        it 'message is correct' do
          expect(subject['text']).to eq('raw_address is missing')
        end
      end
      context 'with price not validated' do
        subject do
          post '/api/v1/orders', params:
            {
              name: 'string',
              raw_address: query,
              price: -15
            }
          JSON.parse(response.body)
        end
        it 'code will be 400' do
          expect(subject['code']).to eq(400)
        end
      end
    end
  end
end
