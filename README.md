# README

To generate embeddings from a pdf:
- Run `python3 scripts/create-embeddings-from-pdf.py --pdf <path_to_pdf>`
- Move the generated CSV to `lib/assets/book.pdf.embeddings.csv`

To run server locally:
- Add a environment configuration file at `config/application.yml` and make sure it has keys
  - OPENAI_API_KEY
  - DB_PASSWORD
- Run `bin/rails db:create` to create the db
- Run `bin/rails db:migrate` to migrate the db
- Run `bin/rails server` to start the server
