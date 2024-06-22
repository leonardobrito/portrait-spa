import { useRef, useState } from "react";
import './StockTicketSearch.css'
import { useFetch } from "../hooks/useFetch";

function StockTicketSearch({ ...rest }) {
  const inputRef = useRef();
  const [query, setQuery] = useState('')

  useFetch(query)

  const handleSearchSubmit = () => {
    const { value } = inputRef.current;

    if (value.length === 0) return;

    setQuery(value)
  }

  return (
    <div {...rest}>
      <label className="search-label" htmlFor="search">
        Enter a Stock Ticket
      </label>
      <input
        ref={inputRef}
        className="search-input"
        id="search"
        placeholder="AAPL"
        type="search"
      />
      <button className="search-button" onClick={handleSearchSubmit}>
        Search
      </button>
    </div>
  )
}

export { StockTicketSearch }
