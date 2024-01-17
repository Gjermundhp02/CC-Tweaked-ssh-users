FROM itzg/minecraft-server:latest

# SSH configuration
RUN apt-get update \
 && apt-get openssh-server -y \
 && apt-get cache 

COPY ./sshd_config /etc/ssh/sshd_config

# Create login user and group
RUN groupadd ccTweaked \
    useradd -M login -g ccTweaked -G sudo
