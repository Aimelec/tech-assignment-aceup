import { useMutation, useQueryClient } from '@tanstack/react-query'
import { useForm } from '@mantine/form'
import { notifications } from '@mantine/notifications'
import { ordersApi } from '../api/orders'
import { orderValidation } from '../utils/orderValidation'
import type { Order, UpdateOrderParams } from '../types/order'

export function useUpdateOrder(order: Order, onClose: () => void) {
  const queryClient = useQueryClient()

  const form = useForm({
    initialValues: {
      customer_name: order.attributes.customer_name,
      customer_email: order.attributes.customer_email,
      description: order.attributes.description ?? '',
      total_amount: parseFloat(order.attributes.total_amount),
      status: order.attributes.status,
    },
    validate: orderValidation,
  })

  const mutation = useMutation({
    mutationFn: (params: UpdateOrderParams) => ordersApi.update(order.id, params),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['orders'] })
      queryClient.invalidateQueries({ queryKey: ['orderStats'] })
      notifications.show({
        title: 'Order updated',
        message: 'The order has been updated successfully.',
        color: 'green',
      })
      onClose()
    },
    onError: () => {
      notifications.show({
        title: 'Update failed',
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
