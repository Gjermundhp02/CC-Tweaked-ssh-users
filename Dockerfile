FROM itzg/minecraft-server:latest

# Change umask, required for chrootdirectory
# RUN sed -i 's/umask 0002/umask 0027/g' /start

# SSH configuration
RUN apt-get update \
 && apt-get install -y openssh-server acl inotify-tools \
 && rm -rf /var/lib/apt/lists/*

COPY ./sshd_config /etc/ssh/sshd_config
COPY ./user-manager.sh /user-manager.sh
COPY ./authorizer.sh /authorizer.sh
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod 755 /authorizer.sh

ENTRYPOINT /entrypoint.sh
