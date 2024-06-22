import { StockTicketSearch } from '../components/StockTicketSearch'
import { StockTicketTable } from '../components/StockTicketTable'
import { Loading } from '../components/Loading'
import { useStockTicket } from '../hooks/useStockTicket'
import './Home.css'

function Home() {
  const { data, isLoading, error } = useStockTicket()

  return (
    <>
      <StockTicketSearch className="search-component" />
      {error && <span className="home-error">{error}</span>}

      {isLoading && <Loading className="home-loading" />}
      {
        data.length > 0 && <StockTicketTable
          className="table-component"
          stockTicket={data}
        />
      }
    </>
  )
}

export { Home }
