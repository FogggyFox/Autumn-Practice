# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: { opened: 'opened', in_work: 'in work', closed: 'closed' }
  self.per_page = 5
  has_many :comments
  belongs_to :user, optional: true

  validates :name, presence: true
  validates :raw_address, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
end
