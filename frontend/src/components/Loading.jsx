import './Loading.css'

function Loading({ ...rest }) {
  return (
    <div {...rest}>
      <span className={`loader`} ></span>
    </div>
  )
}

export { Loading }
