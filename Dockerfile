FROM elixir:1.5

EXPOSE 80

WORKDIR /code
VOLUME /code

ENV MIX_ENV prod
ENV PORT 80

COPY . .

RUN apt-get update && apt-get install -y postgresql-client

RUN \
  mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force && \
  mix local.rebar --force && \
  mix local.hex --force && \
  mix deps.get --only-prod && \
  mix compile

LABEL maintainer="Benjamin Rosas <ben.rosas@gmx.us>"

CMD mix do ecto.migrate, phx.server
