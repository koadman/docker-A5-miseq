FROM debian:jessie
MAINTAINER Aaron Darling, aaron.darling@uts.edu.au

RUN apt-get update -y
RUN apt-get install -y gcc build-essential make sed autoconf fastx-toolkit

# See https://groups.google.com/d/msg/hku-idba/RzTkrVTod8o/kNj_ZghK4eQJ
# This is why 1.0.9 is used instead of the latest 1.1.2
ADD http://downloads.sourceforge.net/project/ngopt/a5_miseq_linux_20140604.tar.gz /tmp/a5_miseq.tar.gz

# See https://groups.google.com/forum/#!topic/hku-idba/T2mcHkDOpBU
RUN mkdir /tmp/idba
RUN tar xzf /tmp/a5_miseq.tar.gz --directory /tmp/a5_miseq --strip-components=1


ADD run /usr/local/bin/
ADD Procfile /
ENTRYPOINT ["/usr/local/bin/run"]
