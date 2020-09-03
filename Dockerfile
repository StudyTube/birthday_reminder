FROM bitwalker/alpine-elixir:1.9.0

RUN apk update \
    && apk upgrade --no-cache \
    && apk add --no-cache \
      nodejs-npm \
      alpine-sdk \
      openssl-dev \
      inotify-tools \
      imagemagick \
    && mix local.rebar --force \
    && mix local.hex --force

WORKDIR /birthday_reminder

COPY . /birthday_reminder

RUN mix do deps.get, deps.compile, compile

RUN cd assets && npm install && cd ..
