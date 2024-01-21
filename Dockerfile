# FTP

FROM centos:8
#FROM node:20.11.0

ARG USER_ID=14
ARG GROUP_ID=50

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum -y update && yum clean all

RUN yum install -y gcc-c++ make
RUN curl -sL https://rpm.nodesource.com/setup_20.x | bash -
RUN yes | yum install -y nodejs

RUN yum install -y \
	vsftpd \
	iproute && yum clean all

RUN usermod -u ${USER_ID} ftp
RUN groupmod -g ${GROUP_ID} ftp

ENV FTP_USER "admin"
ENV FTP_PASS "Node_Project_2024_Password"
ENV PASV_ADDRESS **IPv4**
ENV PASV_ADDR_RESOLVE NO
ENV PASV_ENABLE YES
ENV PASV_MIN_PORT 22100
ENV PASV_MAX_PORT 22110
ENV PASV_ADDRESS_ENABLE NO
ENV XFERLOG_STD_FORMAT NO
ENV LOG_STDOUT **Boolean**
ENV FILE_OPEN_MODE 0666
ENV LOCAL_UMASK 077
ENV REVERSE_LOOKUP_ENABLE YES
ENV PASV_PROMISCUOUS NO
ENV PORT_PROMISCUOUS NO

COPY vsftpd.conf /etc/vsftpd/
COPY vsftpd_virtual /etc/pam.d/
COPY run-vsftpd.sh /usr/sbin/

RUN mkdir -p /home/vsftpd/admin
COPY package.json /home/vsftpd/admin
COPY app.js /home/vsftpd/admin

COPY start.sh /usr/sbin/
RUN chmod +x /usr/sbin/start.sh

RUN chmod +x /usr/sbin/run-vsftpd.sh
RUN mkdir -p /home/vsftpd/
RUN chown -R ftp:ftp /home/vsftpd/

VOLUME /home/vsftpd/admin
VOLUME /var/log/vsftpd

EXPOSE 20 21

# Node.js

#RUN mkdir -p /home/vsftpd/admin
WORKDIR /home/vsftpd/admin
RUN npm install -g -f yarn

EXPOSE 8081

CMD ["/usr/sbin/start.sh"]