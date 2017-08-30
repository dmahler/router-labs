FROM ubuntu:14.04
RUN apt-get update && apt-get install -y \
  quagga \
  supervisor \
  telnet \
  tcpdump
CMD chown quagga.quaggavty /etc/quagga/*.conf
CMD chmod 640 /etc/quagga/*.conf
CMD /etc/init.d/quagga start
CMD /bin/sh