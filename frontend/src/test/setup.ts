import '@testing-library/jest-dom'

// Mantine's SegmentedControl uses ResizeObserver, which jsdom doesn't implement.
window.ResizeObserver = class {
  observe() {}
  unobserve() {}
  disconnect() {}
}

// Mantine uses window.matchMedia for color scheme detection, which jsdom doesn't implement.
Object.defineProperty(window, 'matchMedia', {
  writable: true,
  value: (query: string) => ({
    matches: false,
    media: query,
    onchange: null,
    addListener: () => {},
    removeListener: () => {},
    addEventListener: () => {},
    removeEventListener: () => {},
    dispatchEvent: () => false,
  }),
})
