FROM ruby:2.6.1-slim
# RUN apt-get clean && apt-get update
# RUN apt-get update 
# RUN apt-get install -y nodejs postgresql-11 postgresql-contrib-11 postgresql-client-11
# RUN apt-get install -y build-essential
# RUN apt-get install -y make g++

# WORKDIR /tmp/company_reports

RUN for i in $(seq 1 8); do mkdir -p "/usr/share/man/man${i}"; done && \
  echo "deb http://ftp.us.debian.org/debian stretch-backports main" >> /etc/apt/sources.list && \
  apt-get update && apt-get install -t stretch-backports -yqq \
  build-essential \
  postgresql-client \
  libpq-dev \
  libxml2-dev \
  libgrpc-dev \
  libldap2-dev \
  libidn11-dev \
  git \
  tzdata \
  curl && \
  rm -rf /usr/share/man /var/lib/apt/lists/*

WORKDIR /app

COPY ./package.json ./
# RUN npm install

COPY ./ ./

RUN gem install bundler:2.1.4
RUN bundle install
# RUN rails db create
# RUN rails db migrate

RUN date -u > BUILD_TIME

CMD ["rails", "s"]