import { Group, Table, Skeleton } from '@mantine/core'
import styles from './OrdersTable.module.css'

const ROW_COUNT = 5
const COLUMNS = [
  { width: '70%' },
  { width: '60%' },
  { width: '80%' },
  { width: '40%' },
  { width: '50%' },
  { width: '30%' },
]

export function OrdersTableSkeleton() {
  return (
    <div className={styles.container}>
      <Table striped>
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
          {Array.from({ length: ROW_COUNT }, (_, row) => (
            <Table.Tr key={row}>
              {COLUMNS.map((col, colIdx) => (
                <Table.Td key={colIdx}>
                  <Skeleton height={24} width={col.width} />
                </Table.Td>
              ))}
            </Table.Tr>
          ))}
        </Table.Tbody>
      </Table>
      <div className={styles.pagination}>
        <Group gap="xs">
          {Array.from({ length: 4 }, (_, i) => (
            <Skeleton key={i} height={32} width={32} radius="sm" />
          ))}
        </Group>
      </div>
    </div>
  )
}
