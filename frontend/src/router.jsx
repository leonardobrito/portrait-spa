import { Home } from './pages/Home'
import { About } from './pages/About'
import { Route, createBrowserRouter, createRoutesFromElements } from 'react-router-dom'

const router = createBrowserRouter(
  createRoutesFromElements(
    <>
      <Route path="/" element={<Home />} />
      <Route path="/about" element={<About />} />
    </>
  )
)

export { router }
