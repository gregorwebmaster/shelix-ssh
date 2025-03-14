FROM alpine:latest

# Install OpenSSH Server and required packages
RUN apk add --no-cache openssh shadow

# Create necessary directories
RUN mkdir -p /run/sshd
RUN mkdir -p /shared

# Generate SSH host keys
RUN ssh-keygen -A

# Add user and set password from environment variables
ARG SSH_USER
ARG SSH_PASSWORD
RUN useradd -m ${SSH_USER} && \
    echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd

# Configure SSH
ARG SSH_PORT=62208
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i "s/#Port 22/Port ${SSH_PORT}/" /etc/ssh/sshd_config

# Set working directory
WORKDIR /shared

# Expose SSH port
EXPOSE ${SSH_PORT}

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]