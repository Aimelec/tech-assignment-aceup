import { useState } from 'react'
import { Button } from '@mantine/core'
import { colors } from '../theme/colors'
import { Header } from '../components/Header/Header'
import { StatsCards } from '../components/StatsCards/StatsCards'
import { OrdersTable } from '../components/OrdersTable/OrdersTable'
import { CreateOrderModal } from '../components/CreateOrderModal/CreateOrderModal'
import styles from './DashboardPage.module.css'

export function DashboardPage() {
  const [modalOpened, setModalOpened] = useState(false)

  return (
    <>
      <Header
        actions={
          <Button color={colors.secondary} onClick={() => setModalOpened(true)}>+ New Order</Button>
        }
      />
      <div className={styles.content}>
        <StatsCards />
        <OrdersTable />
      </div>
      <CreateOrderModal
        opened={modalOpened}
        onClose={() => setModalOpened(false)}
      />
    </>
  )
}
