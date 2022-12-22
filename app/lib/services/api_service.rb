# frozen_string_literal: true

module Services
  class ApiService
    def self.do_get_request(query)
      conn = Faraday.new('https://addressator.dellin.ru', request: { timeout: 5 }) do |f|
        f.response :json
      end
      conn.get('/api/v2/address') do |req|
        req.params['query'] = "\"#{query}\""
      end
    end

    def self.get_kladr(query)
      json_ans = do_get_request(query)
      json_ans.body&.dig('addresses', 0, 'kladr', 'code')
    end
  end
end
