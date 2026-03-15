import { useState } from 'react'
import { Table, ActionIcon, Group } from '@mantine/core'
import { IconTrash, IconEdit } from '@tabler/icons-react'
import { OrderStatusBadge } from '../OrderStatusBadge/OrderStatusBadge'
import { UpdateOrderModal } from '../UpdateOrderModal/UpdateOrderModal'
import { useDeleteOrder } from '../../hooks/useDeleteOrder'
import type { Order } from '../../types/order'
import styles from './OrderRow.module.css'

interface OrderRowProps {
  order: Order
}

export function OrderRow({ order }: OrderRowProps) {
  const { attributes } = order
  const { confirmDelete, isPending } = useDeleteOrder()
  const [editOpened, setEditOpened] = useState(false)

  return (
    <>
      <Table.Tr className={styles.row}>
        <Table.Td>{attributes.customer_name}</Table.Td>
        <Table.Td>{attributes.customer_email}</Table.Td>
        <Table.Td>{attributes.description}</Table.Td>
        <Table.Td>${attributes.total_amount}</Table.Td>
        <Table.Td>
          <OrderStatusBadge status={attributes.status} />
        </Table.Td>
        <Table.Td>
          <Group gap="xs" className={styles.actions}>
            <ActionIcon variant="subtle" color="blue" onClick={() => setEditOpened(true)}>
              <IconEdit size={16} />
            </ActionIcon>
            <ActionIcon
              variant="subtle"
              color="red"
              onClick={() => confirmDelete(order.id, attributes.customer_name)}
              loading={isPending}
            >
              <IconTrash size={16} />
            </ActionIcon>
          </Group>
        </Table.Td>
      </Table.Tr>
      <UpdateOrderModal
        order={order}
        opened={editOpened}
        onClose={() => setEditOpened(false)}
      />
    </>
  )
}
