FROM elixir:1.13.4-alpine

RUN apk add postgresql-client

RUN mix local.hex --force

RUN mkdir /app

WORKDIR /app
COPY mix.* .
RUN mix deps.get

COPY . .

RUN mix do compile

CMD ["/app/entrypoint.sh"]
