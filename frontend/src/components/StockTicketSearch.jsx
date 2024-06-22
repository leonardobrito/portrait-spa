import { useState } from "react";
import './StockTicketSearch.css'
import { useFetch } from "../hooks/useFetch";

function StockTicketSearch({ ...rest }) {
  const [query, setQuery] = useState('')
  const [input, setInput] = useState('')

  useFetch(query)

  const handleInputChange = (event) => {
    setInput(event.target.value)
  }

  const handleSearchSubmit = () => {
    if (input.length === 0) return;
    setQuery(input)
  }

  return (
    <div {...rest}>
      <label className="search-label" htmlFor="search">
        Enter a Stock Ticket
      </label>
      <input
        className="search-input"
        id="search"
        onChange={handleInputChange}
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
