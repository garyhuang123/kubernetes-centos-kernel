# Kubernetes-CentOS-Kernel

Kubernetes-CentOS-Kernel aims to build an enhanced CentOS kernel to run Kubernetes > 1.8 safely. If you are running Kubernetes on CentOS, you may encounter some critical issues which would crash your guest operating system. Kubernetes-CentOS-Kernel fixes those critial issues for you. To be noticed, you will use it at your own risk. It is not suggested to use in production environment.

### Current fixed issues
* *SLUB: Unable to allocate memory on node -1*

  Fixed by disabling the Kernel Memory Accounting which is only experimental on kernel 3.10
  
* *kernel:[921702.796883] unregister_netdevice: waiting for eth0 to become free. Usage count = 1*

  Fixed according to [net: tcp: close sock if net namespace is exiting](https://github.com/torvalds/linux/commit/4ee806d51176ba7b8ff1efd81f271d7252e03a1d)

### Build kernel
```
cd kubernetes-centos-kernel
sh run.sh
```

### Get rpm

rpmbuild/RPMS/x86_64/kernel-3.10.0-957.10.2.el7.x86_64.rpm

### Upgrade kernel
```
rpm -Uvh kernel-3.10.0-957.10.2.el7.x86_64.rpm
```

#### Has dependency issues
```
yum localinstall kernel-3.10.0-957.10.2.el7.x86_64.rpm
```

## Notice

**It is not suggested to use in production environment.**

Use it at your own risk.
