import { client } from './client'
import type { OrderStatsResponse } from '../types/order'

export const ordersApi = {
  getStats: async (): Promise<OrderStatsResponse> => {
    const response = await client.get<OrderStatsResponse>('/api/orders/stats')
    return response.data
  },
}
