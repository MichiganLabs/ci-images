[![Build status](https://github.com/michiganlabs/ci-images/actions/workflows/build.yml/badge.svg)](https://github.com/MichiganLabs/ci-images/actions)

## Python
Python images are based on the "slim" versions of the official `python` image.

Images come with the following additional tools installed:

* `sudo`
* `make`
* `poetry` and `pipenv`
* `build-essential`
* `libpq-dev`

See [available versions here](https://hub.docker.com/repository/docker/michiganlabs/python/tags?page=1&ordering=name).

## Android
Android images are based on `openjdk:11-jdk-slim-buster`.

Images come with the following additional tools installed:

* Android SDK
* Android build tools (last 3 versions)
* Android emulator
* Ruby (and Bundler)
* Python
* `sudo`
* `git`
* `make`

See [available versions here](https://hub.docker.com/repository/docker/michiganlabs/android/tags?page=1&ordering=name).

## Android JDK 8
This is a variation of the android image based on `openjdk:8-jdk-slim`.

Images come with the following additional tools installed:

* Android SDK
* Android build tools (last 3 versions)
* Android emulator
* Ruby (and Bundler)
* Python
* `sudo`
* `git`
* `make`

See [available versions here](https://hub.docker.com/repository/docker/michiganlabs/android-jdk8/tags?page=1&ordering=name).
