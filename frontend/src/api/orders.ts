import { client } from './client'
import type { OrderStatsResponse, OrdersResponse } from '../types/order'

export const ordersApi = {
  getStats: async (): Promise<OrderStatsResponse> => {
    const response = await client.get<OrderStatsResponse>('/api/orders/stats')
    return response.data
  },

  list: async (page: number): Promise<OrdersResponse> => {
    const response = await client.get<OrdersResponse>('/api/orders', {
      params: { page },
    })
    return response.data
  },
}
