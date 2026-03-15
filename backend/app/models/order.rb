# == Schema Information
#
# Table name: orders
#
#  id             :bigint           not null, primary key
#  customer_name  :string           not null
#  customer_email :string           not null
#  description    :text
#  total_amount   :decimal(10, 2)   default(0.0), not null
#  status         :integer          default("in_progress"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_orders_on_created_at  (created_at)
#  index_orders_on_status      (status)
#
class Order < ApplicationRecord
  enum :status, { in_progress: 0, completed: 1, cancelled: 2 }

  validates :customer_name, presence: true
  validates :customer_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :recent, -> { order(created_at: :desc) }
end
