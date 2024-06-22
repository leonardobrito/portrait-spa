import { useSelector } from 'react-redux'

const useStockTicket = () => {
  const { data, isLoading, error } = useSelector((state) => state.stockTicket)

  return { data, isLoading, error };
};

export { useStockTicket }
