FROM phusion/passenger-ruby25 AS devel
MAINTAINER Thomas Nalevajko <thomas.nalevajko@gmail.com>

ENV DOCKERFILE_PATH .docker
ENV APP_USER app
ENV APP_HOME /var/www/html


# Enable webserver
RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default
ADD $DOCKERFILE_PATH/nginx.conf /etc/nginx/sites-enabled/app.conf
ADD $DOCKERFILE_PATH/nginx-env.conf /etc/nginx/main.d/app-env.conf


# Install system packages
RUN apt-get update && apt-get install \
  -y --no-install-recommends \
  postgresql-client \
  sudo && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "$APP_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/app


# Persist bundle
ENV BUNDLE_PATH /bundle
RUN mkdir $BUNDLE_PATH
RUN chown -R $APP_USER:$APP_USER $BUNDLE_PATH


# Persist 'app' user home for commands history, etc.
VOLUME /home/app
RUN chown -R $APP_USER:$APP_USER /home/app


USER $APP_USER
RUN gem install bundler
RUN gem install rails
RUN gem install rspec
RUN gem install spring
RUN gem install rubocop
USER root

WORKDIR $APP_HOME

COPY $DOCKERFILE_PATH/entrypoint.sh /
CMD ["/entrypoint.sh"]


FROM devel

# Copy source code
COPY . $APP_HOME
RUN chown -R $APP_USER:$APP_USER $APP_HOME

USER $APP_USER
RUN bundle config --local path $BUNDLE_PATH
RUN bundle install
USER root
