# kernel-updater
Shell Script to update kernel.

## System Requirements
- CentOS7

## Usage
### Updating

```
$ bash kernel-updater.sh
$ sudo reboot
```

### After rebooting

Check installed kernel version.

```
$ uname -r
```

Remove old kernel.

```
$ sudo yum remove kernel
```

Check installed kernels.

```
$ rpm -qa kernel\* | sort
```

