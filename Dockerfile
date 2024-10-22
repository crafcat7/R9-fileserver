FROM debian:stable

RUN apt-get update
RUN apt-get install -y curl build-essential socat
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
WORKDIR /R9-fileserver
RUN rustup default nightly
RUN rustup default stable
COPY Cargo.toml .
COPY Cargo.lock .
COPY src ./src
COPY tests ./tests
RUN cargo build --release --bin R9-fileserver --features="build-binary"
RUN cargo +nightly test --release --no-run
RUN mkdir mnt_tests

WORKDIR /work
COPY docker_client_start.sh .
COPY docker_client_external_start.sh .
COPY docker_server_start.sh .
RUN mkdir ./server_root_fs
RUN mkdir ./client_fs

VOLUME /golem/input /golem/output
