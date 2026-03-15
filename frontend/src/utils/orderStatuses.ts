import type { OrderStatus } from '../types/order'

export const STATUS_COLORS: Record<OrderStatus, string> = {
  in_progress: 'blue',
  completed: 'green',
  cancelled: 'red',
}

export const STATUSES: { value: OrderStatus; label: string }[] = [
  { value: 'in_progress', label: 'In Progress' },
  { value: 'completed', label: 'Completed' },
  { value: 'cancelled', label: 'Cancelled' },
]
