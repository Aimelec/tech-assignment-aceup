import { MantineProvider } from '@mantine/core'
import { ModalsProvider } from '@mantine/modals'
import { Notifications } from '@mantine/notifications'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { DashboardPage } from './pages/DashboardPage'
import { StyleProvider } from './theme/StyleProvider'
import '@mantine/core/styles.css'
import '@mantine/notifications/styles.css'

const queryClient = new QueryClient()

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <MantineProvider>
        <ModalsProvider>
          <StyleProvider>
            <Notifications position="top-right" />
            <DashboardPage />
          </StyleProvider>
        </ModalsProvider>
      </MantineProvider>
    </QueryClientProvider>
  )
}

export default App
