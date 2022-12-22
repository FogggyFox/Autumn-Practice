# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  describe 'GET /api/v1/orders/#{order.id}' do
    let!(:order) { FactoryBot.create(:order) }
    subject do
      get "/api/v1/orders/#{order.id}"
      Order.last
    end

    it 'returns right order' do
      subject
      expect(JSON.parse(response.body)['order']['id']).to eq(subject.id)
    end

  end
end
