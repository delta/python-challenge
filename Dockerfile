FROM elixir:1.13.4-alpine

RUN apk add postgresql-client

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix local.hex --force

RUN mix do compile

CMD ["/app/entrypoint.sh"]
