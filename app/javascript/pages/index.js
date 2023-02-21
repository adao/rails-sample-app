import { render } from "react-dom"
import h from 'tools/htm-create-element';

function Header() {
  return h`
    <header>
      <img src="https://askmybook.com/static/book.2a513df7cb86.png" />
    </header>
  `
}

function PageIndex() {
  return h`
    <${Header} />
  `
}


render(
  h`<${PageIndex} />`,
  document.getElementById("pages-index-root")
)
