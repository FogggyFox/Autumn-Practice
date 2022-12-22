module Services
  class TransferService

    def self.transfer_money(sender_id, getter_id, money)
      sender = User.find(sender_id)
      getter = User.find(getter_id)
      money = money.to_d
      return unless sender.balance >= money && getter.balance >= 0

      begin
        ActiveRecord::Base.transaction do
          sender.update!(balance: sender.balance - money)
          getter.update!(balance: getter.balance + money)
        end
      rescue StandardError
        p 'Transaction error'
      end

    end

    def self.transfer_orders(sender_id, getter_id)
      begin
        ActiveRecord::Base.transaction do
          Order.where(user_id: sender_id).find_each do |order|
            order.update!(user_id: getter_id)
          end
        end
      rescue StandardError
        p 'Transaction error'
      end
    end
  end
end

