FROM ubuntu:18.04
LABEL \
  maintainer="Lisa Seelye https://github.com/lisa"

RUN \
  apt-get update && apt-get install -y ansible

ADD . /opt/ansible-vault-demo

WORKDIR /opt/ansible-vault-demo

CMD ["./run_demo.sh"]