FROM ruby:2.5-alpine

ARG USER=rails
ARG GROUP=rails
ARG HOME=/home/rails
ENV HOME_DIR=$HOME
ENV APP_DIR=$HOME_DIR/app
ENV GEM_DIR=$HOME_DIR/.gem
ENV BUNDLE_DIR=$HOME_DIR/.bundle
ENV BUNDLE_PATH=$GEM_DIR/ruby/2.5.0
ENV PATH=$PATH:$BUNDLE_DIR/bin

RUN addgroup $GROUP && adduser -D -G $GROUP $USER -h $HOME_DIR

RUN apk --update add --no-cache \
  build-base \
  libxml2-dev \
  libxslt-dev \
  nodejs \
  npm \
  yarn \
  tzdata \
  sqlite \
  sqlite-dev \
  sqlite-libs \
  && rm -rf /var/cache/apk/*

RUN echo "gem: --user-install --no-rdoc --no-ri" > $HOME_DIR/.gemrc
RUN mkdir -p $APP_DIR $GEM_DIR
RUN chown -R $USER:$GROUP $APP_DIR $GEM_DIR $HOME_DIR/.gemrc

WORKDIR $APP_DIR

VOLUME $GEM_DIR

EXPOSE 3000

CMD ["./docker/startup.sh"]

ENTRYPOINT ["./docker/entrypoint.sh"]
