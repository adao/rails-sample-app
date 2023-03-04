require 'csv'
require 'matrix'
require './lib/openai_api'

def sample_questions
  <<-TEXT
Q: How to choose what business to start?
A: First off don't be in a rush. Look around you, see what problems you or other people are facing, and solve one of these problems if you see some overlap with your passions or skills. Or, even if you don't see an overlap, imagine how you would solve that problem anyway. Start super, super small.

Q: Should we start the business on the side first or should we put full effort right from the start?
A: Always on the side. Things start small and get bigger from there, and I don't know if I would ever “fully” commit to something unless I had some semblance of customer traction. Like with this product I'm working on now!

Q: Should we sell first than build or the other way around?
A: I would recommend building first. Building will teach you a lot, and too many people use “sales” as an excuse to never learn essential skills like building. You can't sell a house you can't build!

Q: Andrew Chen has a book on this so maybe touché, but how should founders think about the cold start problem? Businesses are hard to start, and even harder to sustain but the latter is somewhat defined and structured, whereas the former is the vast unknown. Not sure if it's worthy, but this is something I have personally struggled with
A: Hey, this is about my book, not his! I would solve the problem from a single player perspective first. For example, Gumroad is useful to a creator looking to sell something even if no one is currently using the platform. Usage helps, but it's not necessary.
  TEXT
end

def vector_similarity(arr1, arr2)
  Vector.elements(arr1).inner_product(Vector.elements(arr2))
end

# Takes a list of tuples (text, embedding) and a single embedding to compare against
# and returns the list sorted from most similar to least similar
def sort_embeddings_by_similarity(text_embeddings, embedding)
  text_embeddings.sort_by do |content, content_embedding| 
    vector_similarity(embedding, content_embedding)
  end
end

# Takes a list of tuples of shape (text, _embedding) 
# Joins the text using 'separator' until 'max_length' is reached
# and returns that
def construct_relevant_text(text_embeddings, separator, max_length)
  relevant_text = ""
  text_embeddings.each do |text, _embedding|
    if relevant_text.length + text.length + separator.length > max_length
      space_left = max_length - relevant_text.length - separator.length
      relevant_text += (separator + text)[0...space_left]
      return relevant_text
    end

    relevant_text += (separator + text)
  end
end

def answer_question(question)
  # Turn question into embedding
  question_embedding = get_query_embedding(question)

  # Load embeddings from book
  csv = CSV.parse(File.read("lib/assets/book.pdf.embeddings.csv"), headers: true)
  book_embeddings = []
  csv.each do |row|
    book_embeddings.push([row["content"], JSON.parse(row["embedding"])])
  end

  # Sort embeddings by vector similarity
  sort_embeddings_by_similarity(book_embeddings, question_embedding)

  # Load as much of the text as possible as context
  max_prompt_length = 500
  relevant_text = construct_relevant_text(book_embeddings, "\n* ", max_prompt_length)

  prompt = ""
  # Construct prompt by
  # 1. Prepending relevant text to sample questions
  prompt = relevant_text + "\n\n" + sample_questions

  # 2. Appending user question
  prompt += "\n\nQ: #{question}"

  # 3. Adding an 'A: ' to prompt text completion
  prompt += "\nA: "

  completion = get_completion(prompt)
  return completion, relevant_text
end
