import type { ReactNode } from 'react'
import styles from './Header.module.css'

interface HeaderProps {
  actions?: ReactNode
}

export function Header({ actions }: HeaderProps) {
  return (
    <header className={styles.header}>
      <h1 className={styles.title}>AceUp Orders</h1>
      {actions}
    </header>
  )
}
