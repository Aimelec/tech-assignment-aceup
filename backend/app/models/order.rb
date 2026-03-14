# == Schema Information
#
# Table name: orders
#
#  id             :bigint           not null, primary key
#  customer_name  :string           not null
#  customer_email :string           not null
#  description    :text
#  total_amount   :decimal(10, 2)   default(0.0), not null
#  status         :integer          default("pending"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_orders_on_created_at  (created_at)
#  index_orders_on_status      (status)
#
class Order < ApplicationRecord
  enum :status, { pending: 0, confirmed: 1, completed: 2, cancelled: 3 }

  validates :customer_name, presence: true
  validates :customer_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :recent, -> { order(created_at: :desc) }
end
