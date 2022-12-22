require 'faker'
require 'sidekiq'
require 'sidekiq/web'
require 'ruby-progressbar'
def create_orders(file)
  threads = []
  8.times do
    threads << Thread.new do
      orders = []
      50.times do
        orders << {
          name: Faker::Name.name,
          raw_address: "#{Faker::Address.city} #{Faker::Address.street_address}",
          price: Faker::Commerce.price(range: 0..1_000_000.00),
          address_kladr: "77#{Faker::Number.number(digits: 23)}",
          status: 'opened',
          user_id: 1
        }
        file.print("1\n")
      end
      Order.import orders, validate: false
    end
  end
  threads.each(&:join)
end

def progress(files)
  count = 0
  progressbar = ProgressBar.create(format: '%a %c/%C %B %p%% %r orders/sec %e',
                                   rate_scale: ->(rate) { rate })
  progressbar.total = 8000
  20.times do p '' end
  while count < 8000
    files.each do |file|
      count += file.readlines.length
    end
    progressbar.progress = count
    progressbar.refresh
  end
end


namespace :orders do
  desc 'TODO'
  task create_many: :environment do
    time_before = Time.now
    files_w = []
    20.times do |i|
      files_w << File.new("./orders#{i}.txt", 'a:UTF-8')
    end
    files_r = []
    20.times do |i|
      files_r << File.new("./orders#{i}.txt", 'r:UTF-8')
    end
    processes = []
    20.times do|i|
      processes << fork { create_orders(files_w[i - 1]) }
    end
    processes.push(fork { progress(files_r) })
    processes.each { |p| Process.waitpid(p) }
    
    time_after = Time.now
    p time_before
    p time_after
    p (time_after - time_before)
    p Order.count
    20.times do |i|
      File.delete("./orders#{i}.txt")
    end
  end


  task update_key: :environment do
    time_before = Time.now
    Order.select(:id).find_each(batch_size: 10000) do |order|
      HardJob.perform_async(order.id)
    end

    time_after = Time.now
    p time_before
    p time_after
    p (time_after - time_before)

  end

  task create_comments: :environment do
    time_before = Time.now
    comments = []
    Order.select(:id).find_each(start: 1, finish: 1000) do |order|
      10.times do
        comments << {
          body: Faker::Lorem.word,
          order_id: order.id
        }
      end
    end
    Comment.import comments
    time_after = Time.now
    p time_before
    p time_after
    p (time_after - time_before)

  end

end
