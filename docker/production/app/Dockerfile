ARG RUBY_VERSION=3.1.2
ARG NODE_VERSION=18

# 最終的なイメージサイズを小さくするため、マルチステージビルドを利用
FROM node:${NODE_VERSION}-alpine AS node
FROM ruby:${RUBY_VERSION}-alpine AS ruby

RUN apk update -qq && \
  apk add \
  build-base \
  curl-dev \
  postgresql-dev \
  gcompat

COPY Gemfile Gemfile.lock ./
RUN bundle install

# 最終的なイメージを構築
FROM ruby:${RUBY_VERSION}-alpine

ENV APP_HOME=/work \
  LANG=C.UTF-8 \
  TZ=Asia/Tokyo \
  RAILS_ENV=production \
  RAILS_LOG_TO_STDOUT=TRUE

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /opt/yarn-* /opt/yarn
RUN ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn

RUN apk update -qq && \
  apk add --no-cache \
  imagemagick \
  tzdata \
  postgresql-dev

WORKDIR $APP_HOME
COPY --from=ruby /usr/local/bundle /usr/local/bundle
COPY . ./
COPY docker/production/app/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
