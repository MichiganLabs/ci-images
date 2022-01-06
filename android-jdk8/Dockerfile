FROM openjdk:8-jdk-slim
LABEL maintainer="jfriend@michiganlabs.com"

# make Apt non-interactive
RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/42_noninteractive \
  && echo 'DPkg::Options "--force-confnew";' >> /etc/apt/apt.conf.d/42_noninteractive

ADD ./circle-android /bin/circle-android
RUN chmod +rx /bin/circle-android

ENV DEBIAN_FRONTEND=noninteractive

RUN echo 'PATH="$HOME/.local/bin:$PATH"' >> /etc/profile.d/user-local-path.sh

# man directory is missing in some base images
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199
RUN apt-get update \
  && mkdir -p /usr/share/man/man1 \
  && apt-get install -y \
    git xvfb apt \
    locales sudo ca-certificates tar gzip parallel \
    net-tools unzip zip bzip2 gnupg curl wget make

# RUN groupadd michiganlabs \
#   && useradd --gid michiganlabs --shell /bin/bash --create-home michiganlabs \
#   && echo 'michiganlabs ALL=NOPASSWD: ALL' >> /etc/sudoers.d/42-michiganlabs \
#   && echo 'Defaults env_keep += "DEBIAN_FRONTEND"' >> /etc/sudoers.d/env_keep

ADD https://raw.githubusercontent.com/circleci/circleci-images/master/android/bin/circle-android /bin/circle-android
RUN chmod +rx /bin/circle-android

# Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Use unicode
RUN locale-gen C.UTF-8 || true
ENV LANG=C.UTF-8

RUN sudo apt-get update -qqy && sudo apt-get install -qqy \
        python-dev \
        python-pip \
        python-setuptools \
        apt-transport-https \
        lsb-release && \
    sudo rm -rf /var/lib/apt/lists/*

RUN sudo apt-get update && sudo apt-get install gcc-multilib && \
    sudo rm -rf /var/lib/apt/lists/* && \
    sudo pip uninstall crcmod && \
    sudo pip install --no-cache -U crcmod

ARG cmdline_tools=https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip
ARG android_home=/opt/android/sdk

# SHA-256 87f6dcf41d4e642e37ba03cb2e387a542aa0bd73cb689a9e7152aad40a6e7a08

RUN sudo apt-get update && \
    sudo apt-get install --yes \
        ruby-dev rubygems \
        xvfb lib32z1 lib32stdc++6 build-essential \
        libcurl4-openssl-dev libglu1-mesa libxi-dev libxmu-dev \
        libglu1-mesa-dev && \
    sudo rm -rf /var/lib/apt/lists/*

# ENV PATH ${HOME}/.rubies/ruby-2.6.1/bin:${PATH}
RUN echo 'gem: --env-shebang --no-rdoc --no-ri' >> ~/.gemrc && gem install bundler

# Download and install Android Commandline Tools
RUN sudo mkdir -p ${android_home}/cmdline-tools && \
    wget -O /tmp/cmdline-tools.zip -t 5 "${cmdline_tools}" && \
    unzip -q /tmp/cmdline-tools.zip -d /tmp/ && \
    rm /tmp/cmdline-tools.zip && \
    mv /tmp/cmdline-tools ${android_home}/cmdline-tools/latest

# Set environmental variables
ENV ANDROID_HOME ${android_home}
ENV ADB_INSTALL_TIMEOUT 120
ENV PATH=${ANDROID_HOME}/emulator:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}

RUN mkdir ~/.android && echo '### User Sources for Android SDK Manager' > ~/.android/repositories.cfg

RUN yes | sdkmanager --licenses && yes | sdkmanager --update

# This installs tools, platform-tools, and emulator. installing those individually creates duplicates in the SDK, bloating image size
RUN sdkmanager "tools"

RUN sdkmanager \
  "build-tools;29.0.2" \
  "build-tools;30.0.2" \
  "build-tools;30.0.3"

ARG ANDROID_SDK_VERSION=31
RUN sdkmanager "platforms;android-$ANDROID_SDK_VERSION"
