FROM mcr.microsoft.com/devcontainers/rust:latest as stylus-builder

RUN apt-get update && apt-get install -y curl git \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g pnpm

RUN rustup install stable && rustup default stable \
    && rustup target add wasm32-unknown-unknown \
    && cargo install --force cargo-stylus

RUN curl -L https://foundry.paradigm.xyz | bash && \
    /root/.foundry/bin/foundryup && \
    echo "Installed Foundry tools:" && ls -la /root/.foundry/bin

ENV PATH="/root/.foundry/bin:$PATH"

COPY run-dev-node.sh /run-dev-node.sh
RUN chmod +x /run-dev-node.sh

FROM offchainlabs/nitro-node:v3.2.1-d81324d

COPY --from=stylus-builder /usr/local/cargo/bin/cargo-stylus /usr/local/bin/cargo-stylus
COPY --from=stylus-builder /run-dev-node.sh /usr/local/bin/run-dev-node.sh
COPY --from=stylus-builder /root/.foundry/bin/cast /usr/local/bin/cast
COPY --from=stylus-builder /root/.foundry/bin/forge /usr/local/bin/forge
COPY --from=stylus-builder /root/.foundry/bin/anvil /usr/local/bin/anvil

WORKDIR /workspace
