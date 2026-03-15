import { Modal, TextInput, NumberInput, Textarea, Button, SegmentedControl, Text } from '@mantine/core'
import { useUpdateOrder } from '../../hooks/useUpdateOrder'
import { colors } from '../../theme/colors'
import { STATUS_COLORS, STATUSES } from '../../utils/orderStatuses'
import type { Order } from '../../types/order'
import styles from './UpdateOrderModal.module.css'

interface UpdateOrderModalProps {
  order: Order
  opened: boolean
  onClose: () => void
}

export function UpdateOrderModal({ order, opened, onClose }: UpdateOrderModalProps) {
  const { form, mutation, handleSubmit, handleClose } = useUpdateOrder(order, onClose)

  return (
    <Modal opened={opened} onClose={handleClose} title={<Text fw={600} size="lg">Edit Order</Text>}>
      <form onSubmit={handleSubmit}>
        <TextInput
          label="Customer Name"
          placeholder="John Smith"
          {...form.getInputProps('customer_name')}
        />
        <TextInput
          label="Customer Email"
          placeholder="john@example.com"
          mt="md"
          {...form.getInputProps('customer_email')}
        />
        <Textarea
          label="Description"
          placeholder="2x Margherita Pizza"
          mt="md"
          {...form.getInputProps('description')}
        />
        <NumberInput
          label="Total Amount"
          placeholder="0.00"
          decimalScale={2}
          hideControls
          min={0}
          mt="md"
          {...form.getInputProps('total_amount')}
        />
        <div className={styles.statusSection}>
          <label className={styles.statusLabel}>Status</label>
          <SegmentedControl
            fullWidth
            color={STATUS_COLORS[form.values.status]}
            data={STATUSES}
            {...form.getInputProps('status')}
          />
        </div>
        <div className={styles.actions}>
          <Button variant="default" onClick={handleClose}>
            Cancel
          </Button>
          <Button type="submit" color={colors.primary} loading={mutation.isPending}>
            Save
          </Button>
        </div>
      </form>
    </Modal>
  )
}
