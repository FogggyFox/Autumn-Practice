module Services
  class SearchOrderService
    def self.search(search, kladr, user)
      unless kladr.blank?
        if search
          orders = user.orders.where(address_kladr: kladr)
          return orders.where('name LIKE ? OR address_kladr LIKE ? OR raw_address LIKE ? OR price LIKE ? or status LIKE ?',
                       "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
        else
          return user.orders.where(address_kladr: kladr)
        end
      end
      if search
        return user.orders.where('name LIKE ? OR address_kladr LIKE ? OR raw_address LIKE ? OR price LIKE ? or status LIKE ?',
                    "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
      end
      user.orders
    end
  end
end
