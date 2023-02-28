#!/user/bin/env ruby

=begin
Purpose:
Read a PDF then generate embeddings for each section of text
General algorithm:
Extract text from PDF. Create embeddings from text
Save somewhere
When asked a question:
Check if question has been asked before
If so: send response with completion
Else:
Create embedding from question
Use vector similarity to rank which pieces of text are most similar
Create prompt of max size from most similar pieces of text
Feed prompt to openapi to get completion
Generate voice from completion response
Save completion, question to db
Send response with completion

Don't worry about voice initially
=end

filename = ARGV[0]
