FROM ruby:2.5.0
LABEL maintainer="dalareo@gmail.com"

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update && apt-get install -y git imagemagick wget

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - \
  && apt-get update && apt-get install -y nodejs

RUN npm install -g npm

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install yarn

RUN gem update --system
RUN gem install decidim

RUN cd /
RUN decidim code -f --branch=0.9-stable

WORKDIR /code

ENV RAILS_ENV=development
ENV PORT=3000

#COPY Gemfile Gemfile.lock ./
RUN bundle install

#COPY . .

#ARG secret_key_base
#ENV SECRET_KEY_BASE=$secret_key_base

#RUN bundle exec rails assets:precompile

#ENV RAILS_SERVE_STATIC_FILES=true
