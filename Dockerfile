FROM debian:13

# install openssh-server daemon & SUDO!
RUN apt-get update \
 && apt-get install -y openssh-server sudo \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* 

# create the default user 'ahab'
RUN useradd -m -s /bin/bash ahab \
 && mkdir -p /home/ahab/.ssh \
 && chmod 700 /home/ahab/.ssh

# copy './authorized_keys' [from the folder w/ this dockerfile] into the image
COPY authorized_keys /home/ahab/.ssh/authorized_keys

# change file access control and ownership to the 'ahab' user and 'ahab' group
RUN chmod 600 /home/ahab/.ssh/authorized_keys \
 && chown -R ahab:ahab /home/ahab/.ssh

# config lines for sshd to not allow passwords and only allow pk auth
RUN echo "PubkeyAuthentication yes"                >> /etc/ssh/sshd_config \
 && echo "AuthorizedKeysFile .ssh/authorized_keys" >> /etc/ssh/sshd_config \ 
 && echo "PasswordAuthentication no"               >> /etc/ssh/sshd_config

# expose this port on the container to the docker engine
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
