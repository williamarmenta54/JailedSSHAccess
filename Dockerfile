FROM ubuntu:20.04

RUN apt update && \
    apt -y install wget git curl coreutils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN wget -O - https://raw.githubusercontent.com/williamarmenta54/JailedSSHAccess/refs/heads/main/set_up_ssh.sh | bash
CMD ["/bin/bash"]
