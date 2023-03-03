import axios from 'axios';

export function askQuestion(question) {
  return axios.post('/ask-question', {
    question
  }).then(resp => resp.data);
}
