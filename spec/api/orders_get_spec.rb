# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  describe 'GET' do
    subject do
      FactoryBot.create_list(:order, 2)
      get '/api/v1/orders'
      JSON.parse(response.body)
    end

    it 'returns all orders' do
      expect(subject.size).to eq(2)
    end

    it 'returns status code 200' do
      subject
      expect(response).to have_http_status(:success)
    end
  end
end
