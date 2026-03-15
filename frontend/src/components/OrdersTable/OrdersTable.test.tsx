import { screen } from '@testing-library/react'
import { describe, it, expect, vi } from 'vitest'
import { renderWithProviders } from '../../test/testUtils'
import { OrdersTable } from './OrdersTable'

vi.mock('../../api/orders', () => ({
  ordersApi: {
    list: vi.fn().mockResolvedValue({
      data: [
        {
          id: '1',
          type: 'order',
          attributes: {
            customer_name: 'John Smith',
            customer_email: 'john@example.com',
            description: '2x Margherita Pizza',
            total_amount: '25.98',
            status: 'completed',
            created_at: '2026-03-15T00:00:00Z',
            updated_at: '2026-03-15T00:00:00Z',
          },
        },
        {
          id: '2',
          type: 'order',
          attributes: {
            customer_name: 'Sarah Johnson',
            customer_email: 'sarah@example.com',
            description: '1x Pepperoni Pizza',
            total_amount: '14.99',
            status: 'pending',
            created_at: '2026-03-15T00:00:00Z',
            updated_at: '2026-03-15T00:00:00Z',
          },
        },
      ],
      meta: {
        current_page: 1,
        total_pages: 1,
        total_count: 2,
      },
    }),
  },
}))

describe('OrdersTable', () => {
  it('renders order rows', async () => {
    renderWithProviders(<OrdersTable />)

    expect(await screen.findByText('John Smith')).toBeInTheDocument()
    expect(screen.getByText('Sarah Johnson')).toBeInTheDocument()
  })

  it('renders order details', async () => {
    renderWithProviders(<OrdersTable />)

    expect(await screen.findByText('john@example.com')).toBeInTheDocument()
    expect(screen.getByText('2x Margherita Pizza')).toBeInTheDocument()
    expect(screen.getByText('$25.98')).toBeInTheDocument()
  })

  it('renders status badges', async () => {
    renderWithProviders(<OrdersTable />)

    expect(await screen.findByText('completed')).toBeInTheDocument()
    expect(screen.getByText('pending')).toBeInTheDocument()
  })
})
