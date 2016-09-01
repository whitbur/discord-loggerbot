FROM ruby:latest

#RUN apt-get update && \
#    apt-get install -y net-tools

# Install gems
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
#COPY . $APP_HOME
