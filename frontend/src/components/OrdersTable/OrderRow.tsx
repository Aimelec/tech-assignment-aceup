import { Table } from '@mantine/core'
import { OrderStatusBadge } from '../OrderStatusBadge/OrderStatusBadge'
import type { Order } from '../../types/order'

interface OrderRowProps {
  order: Order
}

export function OrderRow({ order }: OrderRowProps) {
  const { attributes } = order

  return (
    <Table.Tr>
      <Table.Td>{attributes.customer_name}</Table.Td>
      <Table.Td>{attributes.customer_email}</Table.Td>
      <Table.Td>{attributes.description}</Table.Td>
      <Table.Td>${attributes.total_amount}</Table.Td>
      <Table.Td>
        <OrderStatusBadge status={attributes.status} />
      </Table.Td>
    </Table.Tr>
  )
}
