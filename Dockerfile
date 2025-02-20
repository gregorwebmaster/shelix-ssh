FROM alpine:latest

# Install OpenSSH Server and required packages
RUN apk add --no-cache openssh shadow

# Create necessary directories
RUN mkdir -p /run/sshd
RUN mkdir -p /shared

# Add user and set password from environment variables
ARG SSH_USER
ARG SSH_PASSWORD
RUN useradd -m ${SSH_USER} && \
    echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd

# Configure SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#Port 22/Port 71028/' /etc/ssh/sshd_config

# Set working directory
WORKDIR /shared

# Expose SSH port
EXPOSE 71028

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]