import { screen } from '@testing-library/react'
import { describe, it, expect, vi } from 'vitest'
import { renderWithProviders } from '../../test/testUtils'
import { StatsCards } from './StatsCards'

vi.mock('../../api/orders', () => ({
  ordersApi: {
    getStats: vi.fn().mockResolvedValue({
      data: {
        type: 'stats',
        attributes: {
          total_orders: 10,
          cancelled_orders: 1,
          completed_orders: 4,
          in_progress_orders: 5,
          total_revenue: '200.0',
        },
      },
    }),
  },
}))

describe('StatsCards', () => {
  it('renders all stat cards', async () => {
    renderWithProviders(<StatsCards />)

    expect(await screen.findByText('10')).toBeInTheDocument()
    expect(screen.getByText('4')).toBeInTheDocument()
    expect(screen.getByText('1')).toBeInTheDocument()
    expect(screen.getByText('5')).toBeInTheDocument()
    expect(screen.getByText('$200.0')).toBeInTheDocument()
  })

  it('renders the stat labels', async () => {
    renderWithProviders(<StatsCards />)

    expect(await screen.findByText('Total Orders')).toBeInTheDocument()
    expect(screen.getByText('Completed')).toBeInTheDocument()
    expect(screen.getByText('Cancelled')).toBeInTheDocument()
    expect(screen.getByText('In Progress')).toBeInTheDocument()
    expect(screen.getByText('Revenue')).toBeInTheDocument()
  })
})
