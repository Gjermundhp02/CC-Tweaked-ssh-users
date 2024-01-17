FROM itzg/minecraft-server:latest

# SSH configuration
RUN apt-get update \
 && apt-get install -y openssh-server \
 && rm -rf /var/lib/apt/lists/*

COPY ./sshd_config /etc/ssh/sshd_config

# Create login user and group
RUN groupadd ccTweaked \
 && useradd -M login -g ccTweaked -G sudo

COPY ./keyFunc.sh /keyFunc.sh
COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
