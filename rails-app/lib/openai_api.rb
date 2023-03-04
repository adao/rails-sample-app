require 'uri'
require 'net/http'

OPENAI_API_KEY = ENV["OPENAI_API_KEY"]

def get_embedding(text, model)
  params = {
    'input': text,
    'model': model
  }
  uri = URI("https://api.openai.com/v1/embeddings")
  req = Net::HTTP::Post.new(uri)
  req['Authorization'] = "Bearer #{OPENAI_API_KEY}"
  req['Content-Type'] = 'application/json'
  req.body = params.to_json

  res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(req)
  end
  body = JSON.parse(res.body)
  return body["data"][0]["embedding"]
end

DEFAULT_QUERY_EMBEDDING_MODEL = 'text-search-curie-query-001'

def get_query_embedding(text, model=DEFAULT_QUERY_EMBEDDING_MODEL)
  get_embedding(text, model)
end

DEFAULT_COMPLETION_MODEL = 'text-davinci-003'
DEFAULT_COMPLETION_TEMPERATURE = 0
DEFAULT_COMPLETION_MAX_TOKENS = 150

def get_completion(prompt, options={})
  params = {
    'prompt': prompt, 
    'model': options[:model] || DEFAULT_COMPLETION_MODEL,
    'temperature': options[:temperature] || DEFAULT_COMPLETION_TEMPERATURE,
    'max_tokens': options[:max_tokens] || DEFAULT_COMPLETION_MAX_TOKENS,
  }
  uri = URI("https://api.openai.com/v1/completions")
  req = Net::HTTP::Post.new(uri)
  req['Authorization'] = "Bearer #{OPENAI_API_KEY}"
  req['Content-Type'] = 'application/json'
  req.body = params.to_json

  res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(req)
  end
  body = JSON.parse(res.body)
  return body["choices"][0]["text"]
end
