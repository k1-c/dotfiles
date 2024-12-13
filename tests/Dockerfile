FROM ubuntu:22.04

RUN apt-get update && apt-get install \
  sudo \
  xz-utils \
	curl \
	-y

RUN adduser k1-c --disabled-password --quiet --gecos "" && \
    echo k1-c:k1-c | chpasswd && \
    adduser k1-c sudo

RUN echo 'k1-c ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers

RUN su k1-c

WORKDIR /home/k1-c/.dotfiles

COPY . /home/k1-c/.dotfiles/

CMD ["bash", "./bin/install.sh"]
