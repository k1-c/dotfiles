FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/testuser
ENV USER=testuser

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    git \
    ca-certificates \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Create test user with sudo privileges
RUN adduser testuser --disabled-password --quiet --gecos "" && \
    echo testuser:testuser | chpasswd && \
    adduser testuser sudo && \
    echo 'testuser ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers

# Switch to test user
USER testuser
WORKDIR $HOME

# Copy dotfiles to container
COPY --chown=testuser:testuser . $HOME/dotfiles/

# Set working directory to dotfiles
WORKDIR $HOME/dotfiles

# Default command runs the installation
CMD ["bash", "./install.sh"]
