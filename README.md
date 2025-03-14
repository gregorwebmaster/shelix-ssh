# SSH File Sharing Container

A Docker container that provides SSH access to shared files.

## Setup

1. Copy the environment template:
`copy .env.dist .env` to `.env`

2. Edit the `.env` file with your preferred settings.

3. Build and start the container:
`docker-compose up -d`

4. Connect to the SSH server:
`ssh -p 62345 myuser@localhost`


## Configuration

You can customize the following in the `.env` file:
- `SSH_USER`: Username for SSH login
- `SSH_PASSWORD`: Password for SSH login
- `SHARED_DIR`: Local directory to share
- `SSH_PORT`: SSH port inside the container
- `HOST_PORT`: Port on the host machine

## Security Notes

- Change the default password
- Consider using SSH keys instead of passwords
- The `.env` file contains sensitive information, keep it secure