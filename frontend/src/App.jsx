import './App.css'
import { Home } from './pages/Home'
import { setupStore } from './store'
import { Provider } from 'react-redux'
function App() {
  return (
    <Provider store={setupStore()}>
      <Home />
    </Provider>
  )
}

export { App }
