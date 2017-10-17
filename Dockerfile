FROM ubuntu:14.04
RUN apt-get update; apt-get upgrade -y
RUN apt-get install -y quagga tcpdump traceroute
RUN mv /usr/sbin/tcpdump /usr/bin/tcpdump
COPY quagga-init /usr/local/bin/
ENV PATH "/usr/lib/quagga/:/sbin:/bin:/usr/sbin:/usr/bin"
ENV VTYSH_PAGER "more"
ENTRYPOINT ["/bin/bash", "-er", "/usr/local/bin/quagga-init"]