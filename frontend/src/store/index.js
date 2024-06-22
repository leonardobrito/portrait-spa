import { combineReducers, configureStore } from '@reduxjs/toolkit'
import stockTicketReducer from './stockTicket'

const rootReducer = combineReducers({
  stockTicket: stockTicketReducer
})

export const setupStore = preloadedState => {
  return configureStore({
    reducer: rootReducer,
    preloadedState
  })
}
