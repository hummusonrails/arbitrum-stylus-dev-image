# Arbitrum Stylus Quickstart Docker Image

> **An all-in-one Docker environment for building and testing Arbitrum Stylus smart contracts.**

## Overview

The **Arbitrum Stylus Quickstart Docker Image** is your streamlined solution for rapid Stylus contract development. Skip setup and jump straight into coding with a preconfigured stack:

- **cargo-stylus** for Stylus contract compilation
- **Foundry tools**: `cast`, `forge`, and `anvil`
- **Node.js** and **pnpm`
- **Nitro devnode** for local testing (JSON-RPC on port 8547)

> [!IMPORTANT]
> Ensure you have both **Docker** and **Docker Compose** installed on your machine before proceeding. You can verify installations with `docker --version` and `docker-compose --version`.

## Getting Started

### 1. Build the Docker Image

```sh
docker build -t hummusonrails/stylus-dev:latest .
```

Or pull the latest published image:

```sh
docker pull hummusonrails/arbitrum-stylus-dev:latest
```

### 2. Launch the Dev Environment

```sh
docker-compose up -d
```

This starts a local Nitro devnet at [`http://localhost:8547`](http://localhost:8547) with the full Stylus toolchain installed.

## Toolchain Summary

| Tool           | Version        |
| -------------- | -------------- |
| cargo-stylus   | latest         |
| cast           | latest         |
| forge          | latest         |
| anvil          | latest         |
| Node.js        | stable         |
| pnpm           | latest         |
| Nitro Node     | v3.2.1-d81324d |

## Ports

| Port  | Description                |
|-------|----------------------------|
| 8547  | Nitro devnode JSON-RPC     |
| 3000  | For frontend/local dev     |

## Usage

You can use the Stylus Docker image in two ways:

<details>
<summary><strong>1. Using this repository locally</strong></summary>

1. Place your Stylus contract(s) in the same folder as the provided <code>docker-compose.yml</code>.
2. Start the environment:

    ```sh
    docker-compose up -d
    docker exec -it stylus-dev bash
    ```

3. Your local project directory is mounted at <code>/workspace</code> inside the container. To build your contract:

    ```sh
    cd /workspace  # already the working directory
    cargo-stylus build
    ```

> [!TIP]
> Any changes you make to your local files are instantly available inside the container thanks to the mounted volume.

</details>

<details>
<summary><strong>2. Using the published image with your own contract</strong></summary>

1. Copy the example Compose file into your Stylus contract project root:

    [examples/docker-compose.yml](./examples/docker-compose.yml)

2. Edit the image reference if needed (e.g., <code>ghcr.io/yourorg/arbitrum-stylus-dev:latest</code>).
3. Start the environment:

    ```sh
    docker-compose up -d
    docker exec -it stylus-dev bash
    ```

4. Your project directory is mounted into <code>/workspace</code> in the container. Run your Stylus build commands (such as <code>cargo stylus build</code>) from there.

> [!TIP]
> Use `cargo-stylus` directly from the command line inside the container, for example: `cargo-stylus build`.

</details>

## Project Structure

```text
arbitrum-stylus-dev-image/
├── Dockerfile              # Main image setup
├── stylus-dev/
│   └── Dockerfile          # Builds Stylus-enabled Nitro node
├── run-dev-node.sh         # Starts dev node and registers cache manager
├── .dockerignore
└── README.md
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
