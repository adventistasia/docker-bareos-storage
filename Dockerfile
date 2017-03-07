FROM       ssdit/bareos-base:16.2
MAINTAINER Ryann Micua <rmicua@ssd.org>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install -y bareos-storage

RUN tar cfvz /etc.tgz /etc/bareos/

ADD run.sh /run.sh
RUN chmod u+x /run.sh

EXPOSE 9103

VOLUME /etc/bareos
VOLUME /var/lib/bareos/storage

ENTRYPOINT ["/run.sh"]
CMD ["/usr/sbin/bareos-sd", "-c", "/etc/bareos/bareos-sd.conf", "-u", "bareos", "-f"]
