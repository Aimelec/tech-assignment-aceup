import { MantineProvider } from '@mantine/core'
import { Notifications } from '@mantine/notifications'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { DashboardPage } from './pages/DashboardPage'
import '@mantine/core/styles.css'
import '@mantine/notifications/styles.css'

const queryClient = new QueryClient()

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <MantineProvider>
        <Notifications position="top-right" />
        <DashboardPage />
      </MantineProvider>
    </QueryClientProvider>
  )
}

export default App
