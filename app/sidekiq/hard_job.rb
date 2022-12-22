class HardJob
  include Sidekiq::Job

  def perform(order_id)
    key = SecureRandom.hex(10)
    Order.find(order_id).update(key:)
  end
end
