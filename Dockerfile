FROM balenalib/rpi-raspbian:stretch
LABEL maintainer="https://github.com/travisbaker"
EXPOSE 80
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" \
  && apt-get install --no-install-recommends -y \
  apache2-utils \
  build-essential \
  cron \
  curl \
  dfu-util \
  git \
  initscripts \
  iproute \
  login \
  php7.0-fpm \
  php7.0-mbstring \
  php7.0-xml \
  python-pip \
  sudo \
  supervisor \
  tzdata \
  vim \
  wget 
RUN groupadd -g 2000 fermentrack \
  && useradd -m -u 2001 -g fermentrack fermentrack
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN curl -L install.fermentrack.com | sudo bash
RUN rm -rf /var/lib/apt/lists/*
CMD ["/usr/bin/supervisord"]