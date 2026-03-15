import { Modal, TextInput, NumberInput, Textarea, Button } from '@mantine/core'
import { useCreateOrder } from '../../hooks/useCreateOrder'
import styles from './CreateOrderModal.module.css'

interface CreateOrderModalProps {
  opened: boolean
  onClose: () => void
}

export function CreateOrderModal({ opened, onClose }: CreateOrderModalProps) {
  const { form, mutation, handleSubmit, handleClose } = useCreateOrder(onClose)

  return (
    <Modal opened={opened} onClose={handleClose} title="New Order">
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
        <div className={styles.actions}>
          <Button variant="default" onClick={handleClose}>
            Cancel
          </Button>
          <Button type="submit" loading={mutation.isPending}>
            Create
          </Button>
        </div>
      </form>
    </Modal>
  )
}
