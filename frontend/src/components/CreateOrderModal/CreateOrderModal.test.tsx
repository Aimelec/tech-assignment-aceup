import { screen, fireEvent, waitFor } from '@testing-library/react'
import { describe, it, expect, vi } from 'vitest'
import { renderWithProviders } from '../../test/testUtils'
import { CreateOrderModal } from './CreateOrderModal'

const mockCreate = vi.fn()

vi.mock('../../api/orders', () => ({
  ordersApi: {
    create: (...args: unknown[]) => mockCreate(...args),
  },
}))

function fillForm(overrides: Partial<Record<string, string>> = {}) {
  const values = {
    'Customer Name': 'John Smith',
    'Customer Email': 'john@example.com',
    Description: '2x Margherita Pizza',
    'Total Amount': '25.98',
    ...overrides,
  }

  Object.entries(values).forEach(([label, value]) => {
    fireEvent.change(screen.getByLabelText(label), { target: { value } })
  })
}

describe('CreateOrderModal', () => {
  const onClose = vi.fn()

  it('renders the form fields', () => {
    renderWithProviders(<CreateOrderModal opened={true} onClose={onClose} />)

    expect(screen.getByLabelText('Customer Name')).toBeInTheDocument()
    expect(screen.getByLabelText('Customer Email')).toBeInTheDocument()
    expect(screen.getByLabelText('Description')).toBeInTheDocument()
    expect(screen.getByLabelText('Total Amount')).toBeInTheDocument()
  })

  it('shows validation errors on empty submit', async () => {
    renderWithProviders(<CreateOrderModal opened={true} onClose={onClose} />)

    fireEvent.click(screen.getByText('Create'))

    await waitFor(() => {
      expect(screen.getByText('Name is required')).toBeInTheDocument()
      expect(screen.getByText('Must be a valid email')).toBeInTheDocument()
    })
  })

  it('submits with valid data', async () => {
    mockCreate.mockResolvedValue({ data: { id: '1', type: 'order', attributes: {} } })

    renderWithProviders(<CreateOrderModal opened={true} onClose={onClose} />)

    fillForm()
    fireEvent.click(screen.getByText('Create'))

    await waitFor(() => {
      expect(mockCreate).toHaveBeenCalledWith({
        customer_name: 'John Smith',
        customer_email: 'john@example.com',
        description: '2x Margherita Pizza',
        total_amount: 25.98,
      })
    })
  })

  it('shows success notification on successful submit', async () => {
    mockCreate.mockResolvedValue({ data: { id: '1', type: 'order', attributes: {} } })

    renderWithProviders(<CreateOrderModal opened={true} onClose={onClose} />)

    fillForm()
    fireEvent.click(screen.getByText('Create'))

    await waitFor(() => {
      expect(screen.getByText('Order created')).toBeInTheDocument()
      expect(
        screen.getByText('A confirmation email has been sent to the customer.'),
      ).toBeInTheDocument()
    })
  })

  it('shows error notification on failed submit', async () => {
    mockCreate.mockRejectedValue(new Error('Server error'))

    renderWithProviders(<CreateOrderModal opened={true} onClose={onClose} />)

    fillForm()
    fireEvent.click(screen.getByText('Create'))

    await waitFor(() => {
      expect(screen.getByText('Order failed')).toBeInTheDocument()
      expect(
        screen.getByText('Something went wrong. Please try again.'),
      ).toBeInTheDocument()
    })
  })
})
