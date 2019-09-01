FROM debian:stretch-slim as builder
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    caffe-cpu \
    git \
    python3 \
    python3-dev \
    python3-numpy \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    && rm -rf /var/lib/apt/lists/*
COPY requirements.txt /opt/open_nsfw/requirements.txt
WORKDIR /opt/open_nsfw
RUN pip3 install -r requirements.txt

FROM builder
#COPY . /opt/open_nsfw
#WORKDIR /opt/open_nsfw
EXPOSE 8080
RUN groupadd -r open_nsfw && useradd --no-log-init -r -g open_nsfw open_nsfw
USER open_nsfw
ENTRYPOINT ["python3", "api.py"]