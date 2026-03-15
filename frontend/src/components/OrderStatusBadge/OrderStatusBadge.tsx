import { Badge } from '@mantine/core'
import { STATUS_COLORS } from '../../utils/orderStatuses'
import type { OrderStatus } from '../../types/order'

interface OrderStatusBadgeProps {
  status: OrderStatus
}

export function OrderStatusBadge({ status }: OrderStatusBadgeProps) {
  return (
    <Badge color={STATUS_COLORS[status]} variant="light">
      {status}
    </Badge>
  )
}
