import { StatsCards } from '../components/StatsCards/StatsCards'
import styles from './DashboardPage.module.css'

export function DashboardPage() {
  return (
    <div className={styles.container}>
      <div className={styles.header}>
        <h1 className={styles.title}>AceUp Orders</h1>
      </div>
      <StatsCards />
    </div>
  )
}
