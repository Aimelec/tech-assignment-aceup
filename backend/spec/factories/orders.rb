FactoryBot.define do
  factory :order do
    customer_name { Faker::Name.name }
    customer_email { Faker::Internet.email }
    description { Faker::Lorem.sentence }
    total_amount { Faker::Commerce.price(range: 10.0..500.0) }
    status { :in_progress }
  end
end
