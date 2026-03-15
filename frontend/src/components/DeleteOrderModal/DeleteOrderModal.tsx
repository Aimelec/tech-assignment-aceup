import { Text } from '@mantine/core'

export function DeleteOrderTitle() {
  return (
    <Text fw={600} size="lg" ta="center" w="100%">
      Delete order
    </Text>
  )
}

export function DeleteOrderMessage({ customerName }: { customerName: string }) {
  return (
    <Text ta="center" size="md" c="dimmed">
      Are you sure you want to delete the order for
      <br />
      <Text span fw={600} inherit>
        {customerName}
      </Text>
      ?
    </Text>
  )
}
