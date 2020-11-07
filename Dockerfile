FROM ruby:2.7.1
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn libssl1.1
# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libssl1.1
RUN mkdir /NanoMindFrontend
WORKDIR /NanoMindFrontend
COPY Gemfile /NanoMindFrontend/Gemfile
COPY Gemfile.lock /NanoMindFrontend/Gemfile.lock
COPY package.json /NanoMindFrontend/package.json
COPY yarn.lock /NanoMindFrontend/yarn.lock
RUN gem install bundler -v '2.1.4'
RUN bundle install
RUN yarn install --check-files
COPY . /NanoMindFrontend
# Rails app
EXPOSE 3000
# Webpack dev server
EXPOSE 3035

#CMD ["rails", "server", "-b", "0.0.0.0"]