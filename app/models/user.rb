# frozen_string_literal: true

class User < ApplicationRecord
  enum role: { admin: 'admin' }
  has_many :orders

  validates :name, presence: true
  validates :role, presence: true
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable
end
