# To build:
#
# docker build --tag gbrail/go-rocksdb-x.y.z .
#
# Then deploy to Docker Hub:
#
# docker push gbrail/go-rocksdb-x.y.z

FROM  golang:1.6-alpine

ENV GO15VENDOREXPERIMENT=1

# Add the "testing" repository to get a dependency that RocksDB needs
# Otherwise build in one big step so that we can have only one new layer
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk add --no-cache coreutils linux-headers libexecinfo-dev@testing musl-dev gcc g++ make curl

RUN \
    mkdir /tools \
 && mkdir /tools/glide \
 && (cd /tools/glide; curl -L https://github.com/Masterminds/glide/releases/download/0.10.1/glide-0.10.1-linux-amd64.tar.gz | tar xzf -) \
 && mv /tools/glide/linux-amd64/glide /usr/local/bin

RUN mkdir -p /tools/snappy \
 && (cd /tools; curl -L https://github.com/google/snappy/releases/download/1.1.3/snappy-1.1.3.tar.gz | tar xzf -) \
 && (cd /tools/snappy-1.1.3; ./configure; make install)

RUN mkdir -p /tools/rocks \
 && (cd /tools; curl -L https://github.com/facebook/rocksdb/archive/v4.2.tar.gz | tar xzf -) \
 && (cd /tools/rocksdb-4.2; make install-shared)

RUN rm -rf /tools
 && apk del gcc g++ make curl
