FROM debian:jessie
MAINTAINER Aaron Darling, aaron.darling@uts.edu.au
# based on Michael Barton's IDBA docker file

RUN apt-get update -y
RUN apt-get install -y openjdk-7-jre-headless file

ADD http://downloads.sourceforge.net/project/ngopt/a5_miseq_linux_20140604.tar.gz /tmp/a5_miseq.tar.gz

RUN mkdir /tmp/a5_miseq
RUN tar xzf /tmp/a5_miseq.tar.gz --directory /tmp/a5_miseq --strip-components=1


ADD run /usr/local/bin/
ADD Procfile /
ENTRYPOINT ["/usr/local/bin/run"]
