FROM ruby:2.1.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN gem install bundler
RUN mkdir /baukis
WORKDIR /baukis
COPY Gemfile /baukis/Gemfile
COPY Gemfile.lock /baukis/Gemfile.lock
RUN bundle install
COPY . /baukis
