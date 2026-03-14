class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.string :customer_name, null: false
      t.string :customer_email, null: false
      t.text :description
      t.decimal :total_amount, precision: 10, scale: 2, null: false, default: 0.0
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :orders, :created_at
    add_index :orders, :status
  end
end
