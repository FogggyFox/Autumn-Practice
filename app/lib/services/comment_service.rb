module Services
  class CommentService
    def self.find_comments(orders)
      h = {}
      orders.includes(:comments).each do |order|
        h["number#{order.id}"] = order.comments
      end
      h
    end
  end
end

