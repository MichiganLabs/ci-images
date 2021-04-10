ARG VERSION=3.9
FROM python:${VERSION}-slim
LABEL repository="https://github.com/michiganlabs/ci-imaages"
LABEL maintainer="jfriend@michiganlabs.com"

ENV DEBIAN_FRONTEND=noninteractive

RUN echo 'PATH="$HOME/.local/bin:$PATH"' >> /etc/profile.d/user-local-path.sh

RUN apt-get update \
    && apt-get install -y --no-install-recommends sudo make git build-essential libpq-dev\
    && rm -rf /var/lib/apt/lists/*

RUN groupadd michiganlabs \
  && useradd --gid michiganlabs --shell /bin/bash --create-home michiganlabs \
  && echo 'michiganlabs ALL=NOPASSWD: ALL' >> /etc/sudoers.d/42-michiganlabs \
  && echo 'Defaults env_keep += "DEBIAN_FRONTEND"' >> /etc/sudoers.d/env_keep

RUN pip install --quiet --no-cache poetry pipenv

USER michiganlabs
ENV PATH /home/michiganlabs/.local/bin:/home/michiganlabs/bin:${PATH}

RUN poetry config virtualenvs.in-project true
