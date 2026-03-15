export interface OrderStats {
  total_orders: number
  cancelled_orders: number
  completed_orders: number
  in_progress_orders: number
  total_revenue: string
}

export interface OrderStatsResponse {
  data: {
    type: 'stats'
    attributes: OrderStats
  }
}

export interface OrderAttributes {
  customer_name: string
  customer_email: string
  description: string | null
  total_amount: string
  status: 'in_progress' | 'completed' | 'cancelled'
  created_at: string
  updated_at: string
}

export interface Order {
  id: string
  type: 'order'
  attributes: OrderAttributes
}

export interface PaginationMeta {
  current_page: number
  total_pages: number
  total_count: number
}

export interface OrdersResponse {
  data: Order[]
  meta: PaginationMeta
}

export interface CreateOrderParams {
  customer_name: string
  customer_email: string
  description: string
  total_amount: number
}

export interface CreateOrderResponse {
  data: Order
}

export type OrderStatus = OrderAttributes['status']

export interface UpdateOrderParams {
  customer_name: string
  customer_email: string
  description: string
  total_amount: number
  status: OrderStatus
}