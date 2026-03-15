import { client } from './client'
import type {
  OrderStatsResponse,
  OrdersResponse,
  CreateOrderParams,
  CreateOrderResponse,
  UpdateOrderParams,
} from '../types/order'

const ORDERS_URL = '/api/orders'

export const ordersApi = {
  getStats: async (): Promise<OrderStatsResponse> => {
    const response = await client.get<OrderStatsResponse>(`${ORDERS_URL}/stats`)
    return response.data
  },

  list: async (page: number): Promise<OrdersResponse> => {
    const response = await client.get<OrdersResponse>(ORDERS_URL, {
      params: { page },
    })
    return response.data
  },

  create: async (params: CreateOrderParams): Promise<CreateOrderResponse> => {
    const response = await client.post<CreateOrderResponse>(ORDERS_URL, {
      order: params,
    })
    return response.data
  },

  update: async (id: string, params: UpdateOrderParams): Promise<CreateOrderResponse> => {
    const response = await client.put<CreateOrderResponse>(`${ORDERS_URL}/${id}`, {
      order: params,
    })
    return response.data
  },

  delete: async (id: string): Promise<void> => {
    await client.delete(`${ORDERS_URL}/${id}`)
  },
}
