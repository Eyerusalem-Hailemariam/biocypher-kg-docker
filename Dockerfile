FROM python:3.11-slim

WORKDIR /app 

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    python3-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*


RUN pip install --no-cache-dir poetry

COPY pyproject.toml poetry.lock* ./

RUN poetry install --without dev --no-root

COPY . .

RUN poetry install --without dev

CMD ["poetry", "run", "python", "create_knowledge_graph.py", "--help"]