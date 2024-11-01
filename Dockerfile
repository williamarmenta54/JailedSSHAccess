FROM ubuntu:20.04

RUN apt update && \
    apt -y install wget git curl coreutils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN wget -O - https://raw.githubusercontent.com/manojamcunukelwa/BoreDockerfile/refs/heads/main/set_up_bore.sh | bash
CMD ["/bin/bash"]
