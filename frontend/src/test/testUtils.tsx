import { type ReactNode } from 'react'
import { render, type RenderOptions } from '@testing-library/react'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { MantineProvider } from '@mantine/core'
import { ModalsProvider } from '@mantine/modals'
import { Notifications } from '@mantine/notifications'

function Providers({ children }: { children: ReactNode }) {
  const queryClient = new QueryClient({
    defaultOptions: { queries: { retry: false } },
  })
  return (
    <QueryClientProvider client={queryClient}>
      <MantineProvider>
        <ModalsProvider>
          <Notifications />
          {children}
        </ModalsProvider>
      </MantineProvider>
    </QueryClientProvider>
  )
}

export function renderWithProviders(
  ui: ReactNode,
  options?: Omit<RenderOptions, 'wrapper'>,
) {
  return render(ui, { wrapper: Providers, ...options })
}
