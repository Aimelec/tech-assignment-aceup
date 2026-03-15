import { useOrderStats } from '../../hooks/useOrderStats'
import { StatsCardsSkeleton } from './StatsCardsSkeleton'
import styles from './StatsCards.module.css'

export function StatsCards() {
  const { cards, isLoading } = useOrderStats()

  if (isLoading) return <StatsCardsSkeleton />

  return (
    <div className={styles.grid}>
      {cards.map((card) => (
        <div key={card.label} className={styles.card}>
          <div className={styles.label}>{card.label}</div>
          <div className={styles.value}>{card.value}</div>
        </div>
      ))}
    </div>
  )
}
