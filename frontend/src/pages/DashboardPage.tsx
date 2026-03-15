import { Header } from '../components/Header/Header'
import { StatsCards } from '../components/StatsCards/StatsCards'
import { OrdersTable } from '../components/OrdersTable/OrdersTable'
import styles from './DashboardPage.module.css'

export function DashboardPage() {
  return (
    <>
      <Header />
      <div className={styles.content}>
        <StatsCards />
        <OrdersTable />
      </div>
    </>
  )
}
