# go-rocksdb

This is a Docker image that includes:

* go (from the standard "go" image)
* glide, for building
* snappy compression library
* RocksDB, as a shared library

The libraries are installed in /usr/local/lib.

Current versions:

* go: 1.6
* glide: 0.10.1
* snappy: 1.1.3
* RocksDB: 4.2
