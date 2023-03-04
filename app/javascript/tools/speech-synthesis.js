export function speakInBrowser(text) {
  const voices = speechSynthesis.getVoices();
  const randomVoice = voices[Math.floor(Math.random() * voices.length)];
  const utterance = new SpeechSynthesisUtterance(text);
  utterance.voice = randomVoice;
  speechSynthesis.speak(utterance);
}
