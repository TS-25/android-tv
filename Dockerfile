FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    qemu-system-x86 \
    qemu-utils \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    wget \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN wget -O android.iso \
    https://osdn.net/projects/android-x86/releases/download/9.0-r2/android-x86_64-9.0-r2.iso

RUN qemu-img create -f qcow2 android.qcow2 16G

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 6080

CMD ["/usr/bin/supervisord","-n"]
