## R9-fileserver

Cross-platform 9p file server implemented in Rust/Tokio.

The work is based on:

- https://github.com/pfpacket/rust-9p
- https://github.com/golemfactory/ya-vm-file-server

Author of original implementation: Ryo Munakata & scx1332

## why separate project

The original purpose of forking this repository was to expand its capabilities and provide real-time maintenance. Therefore, we expanded on the basis of the original repository:
- Support for macOS capabilities
- More Support for 9P Protocol (refer to https://github.com/chaos/diod/blob/master/protocol.md)
- Fixes for implementation issues

## Build

To compile only library part:

```bash
cargo build
```

To compile binary:

```bash
cargo build --bin R9-fileserver --features="build-binary debug-msg"
```

## Testing

Build docker:

```
docker build . -t R9-fileserver
```

Running docker tests

```
docker-compose up
```

### Integration tests
Tests are half-automatic. First you need to prepare an environment:
1) Launch 9p server:

   ```
   RUST_LOG=debug cargo run --features="build-binary" -- --mount-point tests/9p_mnt_point
   ```

3) On other shell mount to the server:

   ```
   cd tests
   sudo mount -t 9p -o version=9p2000.L,trans=tcp,debug=0x04,port=7878,uname=testuser 127.0.0.1 ./mnt_tests
   ```

4) Launch tests using **nightly** build:

   ```
   cargo +nightly test
   ```

You should be able to see logging on the server side while tests are running.


## Licence

Keeping original implementation licence BSD-3

