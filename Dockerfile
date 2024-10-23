FROM python:3.11-slim

ENV GITHUB_TOKEN=${GITHUB_TOKEN}
ENV GITHUB_REPOSITORY=${GITHUB_REPOSITORY}
ENV GITHUB_SHA=${GITHUB_SHA}
ENV PATH="/home/.poetry/bin:/home/app/.poetry/bin:$PATH"

RUN apt-get update \
    && pip install poetry==1.8.4 \
    && apt-get install -y --no-install-recommends git ssh-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app/

RUN chmod +x /app/entrypoint.sh

RUN poetry config virtualenvs.create false \
    && poetry install

ENTRYPOINT ["/app/entrypoint.sh"]
