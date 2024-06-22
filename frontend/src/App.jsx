import './App.css'
import { router } from './router';

import { setupStore } from './store'
import { Provider } from 'react-redux'
import { RouterProvider } from "react-router-dom";

function App() {
  return (
    <Provider store={setupStore()}>
      <RouterProvider router={router} />
    </Provider>
  )
}

export { App }
