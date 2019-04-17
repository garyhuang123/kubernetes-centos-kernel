# Kubernetes-CentOS-Kernel

Kubernetes-CentOS-Kernel aims to build an enhanced CentOS kernel to run Kubernetes safely. If you are running Kubernetes on CentOS, you may encounter some critical issues that would crash your guest operating system. Kubernetes-CentOS-Kernel fixes those critical issues for you.

To be noticed, you will use it at your own risk. It is not suggested to use in production environment.


### Current fixed issues
* *SLUB: Unable to allocate memory on node -1*

  Fixed by disabling the Kernel Memory Accounting which is only experimental on kernel 3.10.
  
* *kernel:[921702.796883] unregister_netdevice: waiting for eth0 to become free. Usage count = 1*

  Fixed according to [net: tcp: close sock if net namespace is exiting](https://github.com/torvalds/linux/commit/4ee806d51176ba7b8ff1efd81f271d7252e03a1d)

### Current kernel upstream
http://vault.centos.org/7.6.1810/updates/Source/SPackages/kernel-3.10.0-957.10.1.el7.src.rpm

### Build kernel

```
cd kubernetes-centos-kernel
sh run.sh
```

### RPM

rpmbuild/RPMS/x86_64/kernel-3.10.0-957.10.1.el7.local.x86_64.rpm

### Upgrade
```
rpm -Uvh kernel-3.10.0-957.10.1.el7.local.x86_64.rpm
```

#### Has dependency issues?
```
yum localinstall kernel-3.10.0-957.10.1.el7.local.x86_64.rpm
```

## Notice

**It is not suggested to use in production environment.**

Use it at your own risk.
