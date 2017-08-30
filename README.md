TODO

aliases somehow - push to profile? just run alias command?

#automate.
docker-compose down --remove-orphans
docker-compose up -d


sudo apt-get install python-netaddr on host

RUN apt-get update
RUN apt-get install quagga
RUN apt-get update && apt-get install -y \
  quagga \
CMD chown quagga.quaggavty ./*.conf
CMD chmod 640 ./*.conf
CMD /etc/init.d/quagga restart


#cleanup remove all containers
docker rm $(docker ps -a -f status=exited -q)