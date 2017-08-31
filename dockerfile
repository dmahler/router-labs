FROM ubuntu:14.04
RUN apt-get update; apt-get upgrade -y
RUN apt-get install -y quagga

RUN chown -R quagga /etc/quagga

COPY quagga-init /usr/local/bin/

ENV PATH "/usr/lib/quagga/:/sbin:/bin:/usr/sbin:/usr/bin"
ENTRYPOINT ["/bin/bash", "-er", "/usr/local/bin/quagga-init"]

