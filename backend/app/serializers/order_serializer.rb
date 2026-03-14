class OrderSerializer
  include JSONAPI::Serializer

  attributes :customer_name, :customer_email, :description, :status, :created_at, :updated_at

  attribute :total_amount do |order|
    order.total_amount.to_s
  end
end
