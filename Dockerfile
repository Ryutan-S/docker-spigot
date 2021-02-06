FROM centos:8

# Convert to CentOS8 Stream
RUN ["dnf","install","-y","centos-release-stream"]
RUN ["dnf","swap","-y","centos-linux-repos","centos-stream-repos"]
RUN ["dnf","distro-sync","-y"]

WORKDIR /root/

RUN curl -LO https://corretto.aws/downloads/resources/15.0.2.7.1/amazon-corretto-15.0.2.7.1-linux-x64.tar.gz && \
  tar -xf amazon-corretto-15.0.2.7.1-linux-x64.tar.gz && \
  mv amazon-corretto-15.0.2.7.1-linux-x64 /usr/local/java && \
  rm amazon-corretto-15.0.2.7.1-linux-x64.tar.gz

ENV PATH $PATH:/usr/local/java/bin
