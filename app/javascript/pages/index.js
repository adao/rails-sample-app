import { render } from "react-dom"
import h from 'tools/htm-create-element';

function Header() {
  return h`
    <header>
      <a>
        <img src="https://askmybook.com/static/book.2a513df7cb86.png" />
      </a>
      <h1>Ask My Book</h1>
    </header>
  `
}

function Main() {
  return h`
    <div class="main">
      <p class="credits">
        This is an experiment in using AI to make my book's content more accessible. Ask a question and AI'll answer it in real time:
      </p>
      <textarea name="question" />
      <div style=${{display: 'none'}} class="buttons-centered">
        <button type="submit">Ask question</button>
        <button class="button-secondary">I'm feeling lucky</button>
      </div>
      <div class="answered-question-container">
        <strong>Answer:</strong>
        <span>The Minimalist Entrepreneur is a book about how to start and grow a business with less stress and fewer resources. It covers topics like how to choose what business to start, how to build and sell your product, and how to manage your time and money.</span>
        <button>Ask another question</button>
      </div>
    </div>
  `
}

function Footer() {
  return h`
    <footer class="credits">
      Project by${" "}
      <a href="https://twitter.com/shl">Sahil Lavingia</a>
      ${" • "}
      <a href="https://github.com/slavingia/askmybook">Fork on GitHub</a>
    </footer>
  `
}

function PageIndex() {
  return h`
    <${Header} />
    <${Main} />
    <${Footer} />
  `
}


render(
  h`<${PageIndex} />`,
  document.getElementById("pages-index-root")
)
