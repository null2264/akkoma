FROM elixir:1.15.4-slim as build

ARG MIX_ENV=prod
ARG OAUTH_CONSUMER_STRATEGIES="twitter facebook google microsoft github keycloak:ueberauth_keycloak_strategy"

WORKDIR /src

RUN apt update &&\
    apt install -y git build-essential cmake libssl-dev libmagic-dev automake autoconf libncurses5-dev &&\
    mix local.hex --force &&\
    mix local.rebar --force

COPY . /src

RUN cd /src &&\
    mix deps.get --only prod &&\
    mkdir release &&\
    mix release --path release

# ---

FROM elixir:1.15.4-slim

ARG BUILD_DATE
ARG VCS_REF

ARG DEBIAN_FRONTEND="noninteractive"
ENV TZ="Etc/UTC"

LABEL org.opencontainers.image.title="akkoma" \
    org.opencontainers.image.documentation="https://gitlab.com/null2264/akkoma" \
    org.opencontainers.image.licenses="AGPL-3.0" \
    org.opencontainers.image.url="https://gitlab.com/null2264/akkoma" \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.created=$BUILD_DATE

ARG GID=4000
ARG UID=4001
ARG HOME=/opt/pleroma
ARG DATA=/var/lib/pleroma

RUN apt update &&\
    apt install -y --no-install-recommends curl ca-certificates imagemagick libmagic-dev ffmpeg libimage-exiftool-perl libncurses5 postgresql-client fasttext &&\
    addgroup --gid $GID pleroma &&\
    adduser --system --shell /bin/false --uid $UID --gid $GID --home $HOME pleroma &&\
    mkdir -p $DATA/uploads &&\
    mkdir -p $DATA/static &&\
    chown -R pleroma:pleroma $DATA &&\
    mkdir -p /etc/pleroma &&\
    chown -R pleroma:pleroma /etc/pleroma &&\
    mkdir -p /usr/share/fasttext &&\
    curl -L https://dl.fbaipublicfiles.com/fasttext/supervised-models/lid.176.ftz -o /usr/share/fasttext/lid.176.ftz &&\
    chmod 0644 /usr/share/fasttext/lid.176.ftz

USER pleroma

COPY --from=build --chown=pleroma:pleroma /src/release ${HOME}

COPY --chown=pleroma:pleroma --chmod=640 ./config/docker.exs /etc/pleroma/config.exs
COPY ./docker-entrypoint.sh ${HOME}

ENTRYPOINT ["/opt/pleroma/docker-entrypoint.sh"]
