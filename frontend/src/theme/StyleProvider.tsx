import type { ReactNode } from 'react'
import { colors } from './colors'

const cssVariables = {
  '--color-primary': colors.primary,
  '--color-secondary': colors.secondary,
} as React.CSSProperties

export function StyleProvider({ children }: { children: ReactNode }) {
  return <div style={cssVariables}>{children}</div>
}
