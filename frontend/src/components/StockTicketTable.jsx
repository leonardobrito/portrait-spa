import './StockTicketTable.css'

function StockTicketTable({ stockTicket, ...rest }) {
  return (
    <div {...rest}>
      <table className="table">
        <thead className="table-head">
          <tr>
            <th className="table-head__th">Item</th>
            <th className="table-head__th">Maximum</th>
            <th className="table-head__th">Minimum</th>
            <th className="table-head__th">Average</th>
          </tr>
        </thead>
        <tbody className="table-body">
          {
            stockTicket.map((ticket, index) =>
              <tr key={index}>
                <td>{ticket.item}</td>
                <td>{ticket.maximum}</td>
                <td>{ticket.minimum}</td>
                <td>{ticket.average}</td>
              </tr>
            )
          }

          <tr>
            <td className="td-foot"></td>
            <td className="td-foot"></td>
            <td className="td-foot"></td>
            <td className="td-foot"></td>
          </tr>
        </tbody>
      </table>
    </div>
  )
}

export { StockTicketTable }
