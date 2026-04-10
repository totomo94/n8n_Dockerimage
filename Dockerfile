FROM n8nio/runners:latest

USER root
RUN cd /opt/runners/task-runner-python && uv pip install requests pandas numpy dask matplotlib seaborn plotly nltk spacy sqlalchemy

# Systempakete für OCR / PDF
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-deu \
    tesseract-ocr-eng \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

# Python-Pakete für OCR
RUN cd /opt/runners/task-runner-python && uv pip install \
    pytesseract \
    pdf2image \
    pypdf \
    pillow

COPY n8n-task-runners.json /etc/n8n-task-runners.json

USER runner
