import { Skeleton } from '@mantine/core'
import styles from './StatsCards.module.css'

const CARD_COUNT = 5

export function StatsCardsSkeleton() {
  return (
    <div className={styles.grid}>
      {Array.from({ length: CARD_COUNT }, (_, i) => (
        <div key={i} className={styles.card}>
          <Skeleton height={14} width="60%" mb="sm" />
          <Skeleton height={34} width="40%" />
        </div>
      ))}
    </div>
  )
}
