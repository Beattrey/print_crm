FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -qq -y --no-install-recommends \
  curl \
  build-essential \
  postgresql-client \
  libpq-dev \
  libcurl4-openssl-dev \
  cron \
  nano \
  gnupg \
  gnupg2 \ 
  gnupg1 \
  libjemalloc2 \
  wget \
  tar \
  unzip \
  libcairo2 \
  libcairo-gobject2 \
  libxt6 \
  libsm6 \
  libice6 \
  libgtk-3-0 \
  libx11-xcb1 \
  libdbus-glib-1-2 \
  psmisc \
  xvfb \
  libappindicator1 \
  libasound2 \
  libatk1.0-0 \
  libatk-bridge2.0-0 \
  libcairo-gobject2 \
  libgconf-2-4 \
  libgtk-3-0 \
  libice6 \
  libnspr4 \
  libnss3 \
  libsm6 \
  libx11-xcb1 \
  libxcomposite1 \
  libxcursor1 \
  libxdamage1 \
  libxfixes3 \
  libxi6 \
  libxinerama1 \
  libxrandr2 \
  libxss1 \
  libxt6 \
  libxtst6 \
  fonts-liberation \
  && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -y
RUN apt-get install yarn -y

# Set environment variables
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV TZ Europe/Kiev
ENV INSTALL_PATH /app
ENV RAILS_ENV production
ENV RACK_ENV production
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2

WORKDIR $INSTALL_PATH

# Copy Gemfile and Gemfile.lock
COPY Gemfile $INSTALL_PATH/Gemfile
COPY Gemfile.lock $INSTALL_PATH/Gemfile.lock

# Install gems
RUN bundle config set without 'development test' && \
    bundle install --jobs $(nproc) --retry 5

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Create necessary directories and set permissions
RUN mkdir -p /app/tmp/pids
RUN touch /app/tmp/pids/server.pid
RUN chown -R nobody:nogroup /app/tmp
RUN chmod 0700 /app/tmp/pids

# Copy the application code
COPY . /app

# CMD ["bin/run-dev.sh"]
