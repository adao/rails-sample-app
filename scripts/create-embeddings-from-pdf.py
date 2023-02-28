import os
import argparse

import pandas as pd
from transformers import GPT2TokenizerFast
import openai
from PyPDF2 import PdfReader

openai.api_key = os.environ["OPENAI_API_KEY"]

# Limit to the size of text the OpenAI API allows
MAX_TOKEN_SIZE = 2046

EMBEDDING_MODEL = f"text-search-curie-doc-001"

tokenizer = GPT2TokenizerFast.from_pretrained("gpt2")

# Grabbing PDF filename
parser=argparse.ArgumentParser()
parser.add_argument("--pdf", help="Name of PDF")
args=parser.parse_args()
filename = f"{args.pdf}"

# Reading PDF
reader = PdfReader(filename)
data = []

# Generate embedding for each page
for page in reader.pages:
    text = " ".join(page.extract_text().split())
    token_count = len(tokenizer.encode(text)) + 4
    if token_count >= MAX_TOKEN_SIZE:
        continue
    result = openai.Embedding.create(
        model=EMBEDDING_MODEL,
        input=text,
    )
    embedding = result["data"][0]["embedding"]
    data.append((text, embedding))

# Save embeddings to CSV
df = pd.DataFrame(data, columns=["content", "embedding"])
df.to_csv(f'{filename}.embeddings.csv')
