FROM nginx

MAINTAINER dhuette13 <dhuette13@yahoo.com>

RUN apt-get update && apt-get install -y \
                git \
                php5-fpm \
                curl \
             && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www
RUN mkdir -p ./gitlist && \
    curl -SL https://s3.amazonaws.com/gitlist/gitlist-master.tar.gz \
    | tar -xzvf - && \
    chmod -R 777 ./gitlist

WORKDIR /var/www/gitlist/
RUN mkdir cache && \
    chmod 777 cache

ADD config.ini .
ADD nginx.conf /etc/nginx
ADD conf/ /etc/nginx/conf/

RUN mkdir -p /repos/sentinel && \
    cd /repos/sentinel && \
    git --bare init .

ADD ./entry.sh /
ENTRYPOINT ["/entry.sh"]
