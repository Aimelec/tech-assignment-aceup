orders = [
  {
    customer_name: "John Smith",
    customer_email: "john@example.com",
    description: "2x Margherita Pizza",
    total_amount: 25.98,
    status: :completed
  },
  {
    customer_name: "Sarah Johnson",
    customer_email: "sarah@example.com",
    description: "1x Chicago Deep Dish, 1x Pepperoni Pizza",
    total_amount: 34.50,
    status: :completed
  },
  {
    customer_name: "Mike Davis",
    customer_email: "mike@example.com",
    description: "3x Pepperoni Pizza",
    total_amount: 41.97,
    status: :cancelled
  },
  {
    customer_name: "Emily Wilson",
    customer_email: "emily@example.com",
    description: "1x Chicago Deep Dish, 2x Margherita Pizza",
    total_amount: 45.99,
    status: :in_progress
  },
  {
    customer_name: "David Brown",
    customer_email: "david@example.com",
    description: "2x Pepperoni Pizza, 1x Margherita Pizza",
    total_amount: 40.97,
    status: :in_progress
  },
  {
    customer_name: "Lisa Taylor",
    customer_email: "lisa@example.com",
    description: "1x Chicago Deep Dish",
    total_amount: 18.99,
    status: :in_progress
  },
  {
    customer_name: "James Anderson",
    customer_email: "james@example.com",
    description: "2x Chicago Deep Dish, 1x Pepperoni Pizza",
    total_amount: 51.97,
    status: :in_progress
  }
]

orders.each { |attrs| Order.find_or_create_by!(attrs) }

puts "Seeded #{orders.size} orders"
