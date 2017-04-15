FROM elixir:1.4

EXPOSE 80
WORKDIR /code

ENV MIX_ENV prod
ENV PORT 80

RUN apt-get update && apt-get install -y postgresql-client

ADD . /code

RUN \
  mix local.hex --force && \
  mix local.rebar --force && \
  mix deps.get --only-prod && \
  mix compile

CMD mix do ecto.migrate, phx.server
