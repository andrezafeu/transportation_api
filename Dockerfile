FROM centurylink/alpine-rails

RUN mkdir /home/app
WORKDIR /home/app

ADD Gemfile /home/app/Gemfile
ADD Gemfile.lock /home/app/Gemfile.lock

RUN apk update && apk --update add ruby-irb ruby-rake ruby-bigdecimal libstdc++ build-base libffi-dev \
  && bundle install
