import { useState, useRef } from 'react';
import { render } from "react-dom"
import { askQuestion } from "clients/main";
import h from 'tools/htm-create-element';

function Header() {
  return h`
    <header>
      <a href="https://www.amazon.com/Minimalist-Entrepreneur-Great-Founders-More/dp/0593192397">
        <img src="https://askmybook.com/static/book.2a513df7cb86.png" />
      </a>
      <h1>Ask My Book</h1>
    </header>
  `
}

function Main() {
  const [isAsking, setIsAsking] = useState(false);
  const [answer, setAnswer] = useState("");
  const [question, setQuestion] = useState("");
  const textAreaEl = useRef(null);
  const askQuestionHandler = () => {
    if (!question)
      return alert("Please ask a question!")
    setIsAsking(true);
    askQuestion(textAreaEl.value)
      .then(answer => {
        setAnswer(answer);
        setIsAsking(false);
      })
      .catch(() => {
        alert("Sorry! There seems to be an issue with our server. Please try again later.");
      })
  }

  const feelLuckyHandler = () => {

  }

  const askAnotherHandler = () => {
    setAnswer("");
    textAreaEl.current.focus();
    textAreaEl.current.select();
  }

  return h`
    <div class="main">
      <p class="credits">
        This is an experiment in using AI to make my book's content more accessible. Ask a question and AI'll answer it in real time:
      </p>
      <textarea ref=${textAreaEl} value=${question} onChange=${e => setQuestion(e.currentTarget.value)} />
      ${answer ? h`
        <div class="answered-question-container">
          <strong>Answer:</strong>
          <span>${answer}</span>
          <button onClick=${askAnotherHandler}>Ask another question</button>
        </div>
      ` : h`
        <div class="buttons-centered">
          <button type="submit" onClick=${askQuestionHandler} disabled=${isAsking}>Ask question</button>
          <button class="button-secondary" onClick=${feelLuckyHandler}>I'm feeling lucky</button>
        </div>
      `}
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
