import { useQuery } from '@tanstack/react-query'
import { ordersApi } from '../api/orders'

export interface StatCard {
  label: string
  value: string | number
}

export function useOrderStats() {
  const query = useQuery({
    queryKey: ['orderStats'],
    queryFn: ordersApi.getStats,
    select: (response) => response.data.attributes,
  })

  const cards: StatCard[] = query.data
    ? [
        { label: 'Total Orders', value: query.data.total_orders },
        { label: 'Completed', value: query.data.completed_orders },
        { label: 'Cancelled', value: query.data.cancelled_orders },
        { label: 'In Progress', value: query.data.in_progress_orders },
        { label: 'Revenue', value: `$${query.data.total_revenue}` },
      ]
    : []

  return { ...query, cards }
}
