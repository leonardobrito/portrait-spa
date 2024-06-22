import { createSlice } from '@reduxjs/toolkit'

const stockTicketSlice = createSlice({
  name: 'stockTicket',
  initialState: {
    data: [],
    error: null,
    isLoading: false,
  },
  reducers: {
    handleError(state, { payload }) {
      return {
        ...state, error: payload
      }
    },
    handleIsLoading(state, { payload }) {
      return {
        ...state, isLoading: payload
      }
    },
    fetched(state, { payload }) {
      return {
        ...state, data: payload
      }
    },
  },
})

export const { fetched, handleIsLoading, handleError } = stockTicketSlice.actions

export default stockTicketSlice.reducer
