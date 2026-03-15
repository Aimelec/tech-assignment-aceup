const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

export const orderValidation = {
  customer_name: (value: string) =>
    value.trim().length === 0 ? 'Name is required' : null,
  customer_email: (value: string) =>
    !EMAIL_REGEX.test(value) ? 'Must be a valid email' : null,
  total_amount: (value: number) =>
    value <= 0 ? 'Must be greater than 0' : null,
}
