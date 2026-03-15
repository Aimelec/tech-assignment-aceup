import { Badge } from '@mantine/core'

const STATUS_COLORS: Record<string, string> = {
  pending: 'yellow',
  confirmed: 'blue',
  completed: 'green',
  cancelled: 'red',
}

interface OrderStatusBadgeProps {
  status: string
}

export function OrderStatusBadge({ status }: OrderStatusBadgeProps) {
  return (
    <Badge color={STATUS_COLORS[status]} variant="light">
      {status}
    </Badge>
  )
}
