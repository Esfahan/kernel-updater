#!/bin/bash
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
sudo rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm

sudo cp elrepo.repo /etc/yum.repos.d/elrepo.repo
sudo chown root:root /etc/yum.repos.d/elrepo.repo 

CUR_DIR='tmp/current_kernels'
rpm -qa kernel\* | sort > ${CUR_DIR}

if [ -e "${CUR_DIR}" ]; then
  CUR_KERNELS=`cat ${CUR_DIR} | tr '\n' ' '`
  sudo yum remove -y ${CUR_KERNELS}
  sudo yum -y update
  sudo yum -y install kernel-ml.x86_64 kernel-ml-devel.x86_64 kernel-ml-headers.x86_64 kernel-ml-tools.x86_64 kernel-ml-tools-libs.x86_64

  sudo awk -F\' '$1=="menuentry " {print $2}' /etc/grub2.cfg
  sudo grub2-set-default 0
  sudo grub2-mkconfig -o /boot/grub2/grub.cfg

  echo ''
  echo '### Execute reboot now ###'
  echo 'sudo reboot'
  echo ''
  echo '### Execute followings after rebooting ###'
  echo 'uname -r'
  echo 'sudo yum remove kernel'
  echo 'rpm -qa kernel\* | sort'
fi
