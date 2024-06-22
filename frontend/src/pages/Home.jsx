import { StockTicketSearch } from '../components/StockTicketSearch'
import { StockTicketTable } from '../components/StockTicketTable'
import { Loading } from '../components/Loading'
import { useStockTicket } from '../hooks/useStockTicket'
import './Home.css'

function Home() {
  const { data, isLoading, error } = useStockTicket()

  return (
    <>
      <StockTicketSearch className="home-stock-ticket-search" />
      {error && <span className="home-error">{error}</span>}

      {isLoading && <Loading className="home-loading" />}
      {
        data.length > 0 && !isLoading && <StockTicketTable
          className="table-component"
          stockTicket={data}
        />
      }
    </>
  )
}

export { Home }
