
FROM fedora:21

RUN yum -y install pyp2rpm emacs-nox fedora-packager

RUN useradd -u 1000 asaha

VOLUME /home/asaha/rpmbuild

# do this later: http://fedoraproject.org/wiki/Using_the_Koji_build_system#Fedora_Account_System_.28FAS2.29_Setup
ADD fix_perms_bash.sh /tmp/fix_perms_bash.sh
CMD /tmp/fix_perms_bash.sh
WORKDIR /home/asaha
