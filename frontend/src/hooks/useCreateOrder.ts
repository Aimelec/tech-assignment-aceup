import { useMutation, useQueryClient } from '@tanstack/react-query'
import { useForm } from '@mantine/form'
import { notifications } from '@mantine/notifications'
import { ordersApi } from '../api/orders'
import type { CreateOrderParams } from '../types/order'

const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

export function useCreateOrder(onClose: () => void) {
  const queryClient = useQueryClient()

  const form = useForm({
    initialValues: {
      customer_name: '',
      customer_email: '',
      description: '',
      total_amount: 0,
    },
    validate: {
      customer_name: (value) =>
        value.trim().length === 0 ? 'Name is required' : null,
      customer_email: (value) =>
        !EMAIL_REGEX.test(value) ? 'Must be a valid email' : null,
      total_amount: (value) =>
        value <= 0 ? 'Must be greater than 0' : null,
    },
  })

  const mutation = useMutation({
    mutationFn: (params: CreateOrderParams) => ordersApi.create(params),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['orders'] })
      queryClient.invalidateQueries({ queryKey: ['orderStats'] })
      notifications.show({
        title: 'Order created',
        message: 'A confirmation email has been sent to the customer.',
        color: 'green',
      })
      form.reset()
      onClose()
    },
    onError: () => {
      notifications.show({
        title: 'Order failed',
        message: 'Something went wrong. Please try again.',
        color: 'red',
      })
    },
  })

  const handleSubmit = form.onSubmit((values) => {
    mutation.mutate(values)
  })

  const handleClose = () => {
    form.reset()
    onClose()
  }

  return { form, mutation, handleSubmit, handleClose }
}
