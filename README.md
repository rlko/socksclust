# socksclust

This project creates a cluster of SOCKS proxies using SSH tunnels. It leverages Docker Compose and environment variables to configure SSH authentication using either key pairs or passwords.

## Features

- Automatically establishes SSH tunnels with SOCKS proxies.
- Supports SSH key pair and password-based authentication.

## Prerequisites

- Docker and Docker Compose installed on your system.
- A remote server with SSH access configured.
- SSH key pairs (or password) for authentication.

## Environment Variables

The following table lists the environment variables that can be set for each SOCKS proxy container:

| **Variable**    | **Description**                                                | **Default** | **Required** |
|-----------------|----------------------------------------------------------------|-------------|--------------|
| `SSH_USER`      | The username for SSH authentication.                           | N/A         | Yes          |
| `SSH_HOST`      | The hostname or IP address of the remote server.               | N/A         | Yes          |
| `SSH_PORT`      | The port for SSH connection.                                   | `22`        | No           |
| `SSH_PASSWORD`  | The password for SSH authentication (if not using SSH key).   | N/A         | No           |
| `SSH_KEY_PATH`  | The path to the SSH private key for key-based authentication.  | `/root/.ssh/id_ed25519` | If using an SSH key |

You can set these variables in the `docker-compose.yml` file or use `.env` files.

## Usage

* **Build and Start the Docker Containers**:
   ```bash
   docker-compose build
   docker-compose up -d
   ```

* **SSH Key Setup**:
   If you are using an SSH key authentication, ensure your SSH private key matches the environment variable **SSH_KEY_PATH** (which is `/root/.ssh/id_ed25519` by default) and is mounted as a volume.

## Docker Compose Configuration Example

```yaml
services:
  socks-proxy-1:
    build: .
    ports:
      - 1080:1080
    environment:
      SSH_USER: user1
      SSH_HOST: remote_server_1
      SSH_PORT: 22
    volumes:
      - ./id_ed25519:/root/.ssh/id_ed25519:ro
    restart: always

  socks-proxy-2:
    build: .
    ports:
      - 1081:1080
    environment:
      SSH_USER: user2
      SSH_HOST: remote_server_2
      SSH_PASSWORD: "verystrongpassword"  # Optional, use either key or password
    restart: always

  socks-proxy-3:
    build: .
    ports:
      - 1082:1080
    environment:
      SSH_USER: user3
      SSH_HOST: remote_server_3
      SSH_KEY_PATH: /root/.ssh/socks_ed25519
    volumes:
      - ./socks_ed25519:/root/.ssh/socks_ed25519:ro
    restart: always
```

## How It Works

1. **SSH Connection**:
   The `entrypoint.sh` script creates an SSH tunnel using the `ssh` command. The SOCKS proxy is configured to listen on port `1080`.

## License

This project is open-source and licensed under the MIT License.
