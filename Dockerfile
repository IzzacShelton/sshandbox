FROM debian:13

# install openssh-server daemon & SUDO!
RUN apt-get update && apt-get install -y openssh-server sudo

# create the default user 'ahab'
RUN useradd -m -s /bin/bash ahab 
RUN mkdir -p /home/ahab/.ssh
RUN chmod 700 /home/ahab/.ssh

# copy './authorized_keys' [from the folder w/ this dockerfile] into the image
COPY authorized_keys /home/ahab/.ssh/authorized_keys

# change file access control and ownership to the 'ahab' user and 'ahab' group
RUN chmod 600 /home/ahab/.ssh/authorized_keys && chown -R ahab:ahab /home/ahab/.ssh

# config lines for sshd to not allow passwords and only allow pk auth
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "AuthorizedKeysFile .ssh/authorized_keys" >> /etc/ssh/sshd_config
RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# sshd needs this to exist 
RUN mkdir /run/sshd

# expose this port on the container to the docker engine
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
