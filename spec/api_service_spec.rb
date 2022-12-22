# frozen_string_literal: true

require 'rails_helper'


RSpec.describe Services::ApiService, type: :model do
  describe '#get_kladr' do
    let(:query) { 'Belgorod Popova 36' }
    subject { Services::ApiService.get_kladr(query) }
    context 'when addressator status is 200' do
      include_context 'stubbing api service'
      it 'returns correct code' do
        expect(subject).to eq(code.to_s)
      end
    end
    context 'when addressator status is 404' do
      before do
        stub_request(:get, "https://addressator.dellin.ru/api/v2/address?query=\"#{query}\"").to_return(
          headers: { 'Content-Type' => 'application/json' },
          status: 404,
          body: nil
        )
      end
      it 'returns nothing' do
        expect(subject).to be_nil
      end
    end
  end
end
