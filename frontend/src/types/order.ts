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
