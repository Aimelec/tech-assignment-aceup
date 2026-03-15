import { useState } from 'react'
import { Table, Pagination, Loader } from '@mantine/core'
import { useOrders } from '../../hooks/useOrders'
import { colors } from '../../theme/colors'
import { OrderRow } from './OrderRow'
import styles from './OrdersTable.module.css'

const INITIAL_PAGE = 1

export function OrdersTable() {
  const [page, setPage] = useState(INITIAL_PAGE)
  const { data, isLoading } = useOrders(page)

  if (isLoading) return <Loader />

  if (!data) return null

  return (
    <div className={styles.container}>
      <Table striped highlightOnHover>
        <Table.Thead>
          <Table.Tr>
            <Table.Th>Name</Table.Th>
            <Table.Th>Email</Table.Th>
            <Table.Th>Description</Table.Th>
            <Table.Th>Amount</Table.Th>
            <Table.Th>Status</Table.Th>
            <Table.Th />
          </Table.Tr>
        </Table.Thead>
        <Table.Tbody>
          {data.data.map((order) => (
            <OrderRow key={order.id} order={order} />
          ))}
        </Table.Tbody>
      </Table>
      <div className={styles.pagination}>
        <Pagination
          total={data.meta.total_pages}
          value={page}
          onChange={setPage}
          color={colors.primary}
        />
      </div>
    </div>
  )
}
