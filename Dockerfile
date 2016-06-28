FROM       ubuntu:trusty
MAINTAINER Kai Wembacher <kai@ktwe.de>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y wget

RUN bash -c 'echo "deb http://download.bareos.org/bareos/release/15.2/xUbuntu_14.04/ /" > /etc/apt/sources.list.d/bareos.list'
RUN bash -c 'wget -q http://download.bareos.org/bareos/release/15.2/xUbuntu_14.04/Release.key -O- | apt-key add -'

RUN apt-get update

RUN bash -c "echo 'postfix postfix/main_mailer_type select No configuration' | debconf-set-selections"

RUN apt-get install -y bareos-storage

RUN tar cfvz /etc.tgz /etc/bareos/

ADD run.sh /run.sh
RUN chmod u+x /run.sh

EXPOSE 9103

VOLUME /etc/bareos
VOLUME /var/lib/bareos/storage

ENTRYPOINT ["/run.sh"]
CMD ["/usr/sbin/bareos-sd", "-c", "/etc/bareos/bareos-sd.conf", "-u", "bareos", "-f"]