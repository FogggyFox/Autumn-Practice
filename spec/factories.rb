# frozen_string_literal: true

require 'factory_bot'
require 'faker'
FactoryBot.define do
  addresses = ['Popova 36 Belgorod', 'Saint-Petersburg Nevsky 34']
  factory :order, class: Order do
    name { Faker::Lorem.sentence }
    raw_address { addresses.sample }
    price { Faker::Number.between(from: 500, to: 10_000) }
    address_kladr { nil }
    status { nil }
  end
end
