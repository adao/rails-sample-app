import axios from 'axios';

export function askQuestion(question) {
  return axios.post('/ask-question', {
    data: { question }
  }).then(resp => resp.data);
}
