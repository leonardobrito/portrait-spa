import { useEffect, useRef } from "react";
import { fetched, handleError, handleIsLoading } from "../store/stockTicket";
import { useDispatch } from "react-redux";

const HOST = 'http://localhost:3000'


const useFetch = (query) => {
  const dispatch = useDispatch()
  const cache = useRef({});
  const url = `${HOST}/api/v1/tickers?ticker_name=${query}`

  useEffect(() => {
    if (!query || query.length === 0) return;

    const fetchData = async () => {
      dispatch(handleError(false))
      dispatch(handleIsLoading(true))

      if (cache.current[url]) {
        const data = cache.current[url];
        dispatch(fetched(data))
      } else {
        try {
          const response = await fetch(url);
          const data = await response.json();

          if (response.status === 404) {
            throw new Error(data.message)
          }

          cache.current[url] = data;
          dispatch(fetched(data))
        } catch (err) {
          console.error(err.message)
          dispatch(handleError(err.message))
          dispatch(fetched([]))
        }
      }

      dispatch(handleIsLoading(false))
    };

    fetchData();
  }, [query]);
};

export { useFetch }
