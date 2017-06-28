FROM debian:jessie

LABEL maintainer="Mapotempo <contact@mapotempo.com>"

RUN apt-get update && \
    apt-get install -y apt-transport-https locales gnupg && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7 && \
    echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger/ jessie main" > /etc/apt/sources.list.d/passenger.list && \
    apt-get update && \
    apt-get install -y nginx-extras passenger bundler && \
    touch /etc/nginx/nginx.env && \
    apt-get clean && \
    echo -n > /var/lib/apt/extended_states && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ENV LC_ALL en_US.UTF-8

ADD nginx.conf /etc/nginx/nginx.conf
ADD vhost.conf /etc/nginx/sites-available/default
ADD conf.d/* /etc/nginx/conf.d/
ADD env.d/* /etc/nginx/env.d/
ADD snippets/* /etc/nginx/snippets/

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    ln -sf /dev/sterr /var/log/nginx/passenger.log

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
