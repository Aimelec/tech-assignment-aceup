import { createElement } from 'react'
import { useMutation, useQueryClient } from '@tanstack/react-query'

import { modals } from '@mantine/modals'
import { notifications } from '@mantine/notifications'
import { ordersApi } from '../api/orders'
import { DeleteOrderTitle, DeleteOrderMessage } from '../components/DeleteOrderModal/DeleteOrderModal'

export function useDeleteOrder() {
  const queryClient = useQueryClient()

  const mutation = useMutation({
    mutationFn: (id: string) => ordersApi.delete(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['orders'] })
      queryClient.invalidateQueries({ queryKey: ['orderStats'] })
      notifications.show({
        title: 'Order deleted',
        message: 'The order has been removed.',
        color: 'green',
      })
    },
    onError: () => {
      notifications.show({
        title: 'Delete failed',
        message: 'Something went wrong. Please try again.',
        color: 'red',
      })
    },
  })

  const confirmDelete = (id: string, customerName: string) => {
    modals.openConfirmModal({
      title: createElement(DeleteOrderTitle),
      children: createElement(DeleteOrderMessage, { customerName }),
      labels: { confirm: 'Delete', cancel: 'Cancel' },
      confirmProps: { color: 'red' },
      groupProps: { justify: 'center' },
      onConfirm: () => mutation.mutate(id),
    })
  }

  return { ...mutation, confirmDelete }
}
