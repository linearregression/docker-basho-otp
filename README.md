# docker-basho-otp

For a few releases in a row now, Basho has packaged a fork of Erlang/OTP along
with Riak/Riak CS. If you're installing Riak/Riak CS from a package, all of
the hard work has been taken care of for you. If you are installing from
source, then you may want to install the forked version of Erlang/OTP as well.

This `Dockerfile` aids building Basho's forked version of Erlang/OTP. The most
recent fork is `R16B02_basho5`, which is meant to be paired with Riak 2.0.

**Note:** All patches included in the Basho fork have already been adopted in
later versions of the official Erlang/OTP release.

## Building

```
$ git clone https://github.com/hectcastro/docker-basho-otp.git
$ cd docker-riak
$ make build
```

## Running

```
$ docker run -t -i hectcastro/basho-otp /bin/bash
root@af6bd028333c:/# erl
Erlang R16B02-basho5 (erts-5.10.3) [source] [64-bit] [smp:4:4] [async-threads:10] [kernel-poll:false]

Eshell V5.10.3  (abort with ^G)
1>
```

## SSH

The [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker)
image has the ability to enable an __insecure__ key for conveniently logging
into a container via SSH. It is enabled in the `Dockerfile` by default here:

```docker
RUN /usr/sbin/enable_insecure_key
```

In order to login to the container via SSH using the __insecure__ key, follow
the steps below.

Use `docker inspect` to determine the container IP address:

```bash
$ docker inspect $CONTAINER_ID | grep IPAddress
        "IPAddress": "172.17.0.2",
```

Download the insecure key, alter its permissions, and use it to SSH into the
container via its IP address:

```bash
$ curl -o insecure_key -fSL https://github.com/phusion/baseimage-docker/raw/master/image/insecure_key
$ chmod 600 insecure_key
$ ssh -i insecure_key root@172.17.0.2
```

**Note:** If you're using
[boot2docker](https://github.com/boot2docker/boot2docker), ensure that you're
issuing the SSH command from within the virtual machine running `boot2docker`.
