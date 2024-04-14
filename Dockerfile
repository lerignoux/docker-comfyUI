FROM nvidia/cuda:12.3.1-runtime-ubuntu22.04
LABEL authors="Laurent Erignoux lerignoux@gmail.com"


ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt-get -y install git python3.10 python3-pip python-is-python3

# Setup global requirements
WORKDIR /srv
COPY requirements.txt /srv/requirements.txt
RUN --mount=type=cache,target=/root/.cache pip install -v --proxy http://192.168.2.3:6665 -r requirements.txt

# setup Comfy
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

RUN --mount=type=cache,target=/root/.cache pip install -v --proxy http://192.168.2.3:6665 -r /srv/ComfyUI/requirements.txt

WORKDIR /srv/ComfyUI
RUN cd /srv/ComfyUI

CMD ["python", "main.py", "--listen", "0.0.0.0", "--multi-user"]
