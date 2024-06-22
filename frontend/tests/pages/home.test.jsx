import { screen, waitFor } from '@testing-library/react'
import { Home } from '../../src/pages/Home.jsx'
import { renderWithProviders } from '../utils/test-utils.jsx'
import userEvent from '@testing-library/user-event'

describe('Home', async () => {
  beforeEach(() => {
    fetch.resetMocks();
  });

  it('renders the Home component', () => {
    renderWithProviders(<Home />)
    const label = screen.getByLabelText('Enter a Stock Ticket')
    expect(label).toBeDefined()
    expect(screen.queryByRole('input', { name: '/search/i' })).toBeDefined()
    expect(screen.queryByRole('button', { name: '/Search/i' })).toBeDefined()
    expect(screen.queryByRole('table')).not.toBeInTheDocument()
  })

  it('should render stock ticket table', async () => {
    fetch.mockResponse(JSON.stringify(
      [
        {
          item: 'Price',
          maximum: '$500',
          minimum: '$100',
          average: '$300'
        },
        {
          item: 'Volume',
          maximum: '1000',
          minimum: '500',
          average: '700'
        },
      ]
    ));

    const user = userEvent.setup()

    renderWithProviders(<Home />)
    const input = screen.getByRole('searchbox')
    await user.type(input, 'AAPL')

    expect(input).toHaveValue('AAPL')

    const button = screen.getByRole('button')
    await user.click(button)

    expect(screen.getByRole('table')).toBeInTheDocument()
  })

  it('should render api error', async () => {
    const errorMessage = 'Fake error message'
    fetch.mockReject(new Error(errorMessage));
    const user = userEvent.setup()

    renderWithProviders(<Home />)

    const input = screen.getByRole('searchbox')
    await user.type(input, 'AAPL')

    const button = screen.getByRole('button')
    await user.click(button)

    expect(screen.queryByRole('table')).not.toBeInTheDocument()
    expect(screen.getByText(errorMessage))
  })
})
