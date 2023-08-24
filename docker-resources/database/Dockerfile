FROM postgres:14-alpine

ARG GID=4000
ARG UID=4001
ARG UNAME=akkoma

RUN addgroup -g $GID $UNAME
RUN adduser -u $UID -G $UNAME -D -h $HOME $UNAME

USER akkoma
