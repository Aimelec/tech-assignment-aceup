import { MantineProvider } from '@mantine/core'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { DashboardPage } from './pages/DashboardPage'
import '@mantine/core/styles.css'

const queryClient = new QueryClient()

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <MantineProvider>
        <DashboardPage />
      </MantineProvider>
    </QueryClientProvider>
  )
}

export default App
