FROM centos:8

# Convert to CentOS8 Stream
RUN ["dnf","install","-y","centos-release-stream"]
RUN ["dnf","swap","-y","centos-linux-repos","centos-stream-repos"]
RUN ["dnf","distro-sync","-y"]

WORKDIR /root/minecraft/

COPY ./config/* ./

# Install component from dnf
RUN dnf install -y git

# Install java
RUN curl -LO https://corretto.aws/downloads/resources/15.0.2.7.1/amazon-corretto-15.0.2.7.1-linux-x64.tar.gz && \
  tar -xf amazon-corretto-15.0.2.7.1-linux-x64.tar.gz && \
  mv amazon-corretto-15.0.2.7.1-linux-x64 /usr/local/java && \
  rm amazon-corretto-15.0.2.7.1-linux-x64.tar.gz

ENV PATH $PATH:/usr/local/java/bin

RUN curl "https://papermc.io/api/v2/projects/paper/versions/1.16.5/builds/467/downloads/paper-1.16.5-467.jar" -o paper.jar && \
  java -jar paper.jar && \
  sed -i -e 's/eula=false/eula=true/' eula.txt

VOLUME ["/root/minecraft/"]

ENTRYPOINT ["java","-Xms1500M","-Xmx1500M","-jar","paper.jar"]
