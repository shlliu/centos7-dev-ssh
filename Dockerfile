# Dockerfile: centos7-dev-ssh
# Start
FROM centos:7.4.1708
# Install Epel
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm && rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
# Install some softwares
RUN yum install -y tar gzip gcc vim wget screen \
                   openssl openssh openssh-clients openssh-server
# Generate ssh key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ed25519_key
# Modify /etc/ssh/sshd_config
RUN sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
RUN sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config
# Create .ssh dir
RUN mkdir -p /root/.ssh && chown root.root /root && chmod 700 /root/.ssh
# Create password for root
RUN echo 'root:P@ssw0rd' | chpasswd
# Expose 22 port
EXPOSE 22
# Start sshd
CMD /usr/sbin/sshd -D
#End
