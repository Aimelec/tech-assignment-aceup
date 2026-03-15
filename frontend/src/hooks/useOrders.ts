import { useQuery } from '@tanstack/react-query'
import { ordersApi } from '../api/orders'

export function useOrders(page: number) {
  return useQuery({
    queryKey: ['orders', page],
    queryFn: () => ordersApi.list(page),
  })
}
