on init
    setprop sys.usb.configfs 1
    setprop sys.usb.ffs.aio_compat 1

    export LD_LIBRARY_PATH /system/lib64:/vendor/lib64:/vendor/lib64/hw:/system/lib64/hw

on fs
    install_keyring   

on boot
    start health-hal-2-1

on fs && property:ro.debuggable=0
    # distinguish USB shoulde connect or not, i.e. CDP vs SDP
    # write /sys/class/udc/musb-hdrc/device/cmode 2
    # set charging free due to it wait for USB activation
    start adbd

on property:hwservicemanager.ready=true
    start teei_daemon
    start keymaster-4-1-beanpod
    start gatekeeper-1-0

on property:ro.crypto.state=unsupported
    stop teei_daemon
    stop keymaster-4-1-beanpod
    stop gatekeeper-1-0
    stop servicemanager
    stop hwservicemanager

on property:ro.crypto.state=unencrypted
    stop teei_daemon
    stop keymaster-4-1-beanpod
    stop gatekeeper-1-0
    stop servicemanager
    stop hwservicemanager

on property:twrp.decrypt.done=true
    stop teei_daemon
    stop keymaster-4-1-beanpod
    stop gatekeeper-1-0
    stop servicemanager
    stop hwservicemanager

service keystore_auth /system/bin/keystore_auth
    oneshot
    user system
    group root
    disabled
    seclabel u:r:recovery:s0

service keystore /system/bin/keystore /tmp/misc/keystore
    user root
    group root drmrpc readproc log
    disabled
    seclabel u:r:recovery:s0

on post-fs
    # Support A/B feature for EMMC and UFS boot region
    wait /dev/block/mmcblk0boot0 2
    symlink /dev/block/sda /dev/block/mmcblk0boot0
    symlink /dev/block/sdb /dev/block/mmcblk0boot1
    symlink /dev/block/mmcblk0boot0 /dev/block/platform/bootdevice/by-name/preloader_a
    symlink /dev/block/mmcblk0boot1 /dev/block/platform/bootdevice/by-name/preloader_b

    # Support A/B feature for combo emmc and ufs OTA update
    symlink /dev/block/platform/bootdevice/by-name/preloader_a /dev/block/platform/bootdevice/by-name/preloader_emmc_a
    symlink /dev/block/platform/bootdevice/by-name/preloader_b /dev/block/platform/bootdevice/by-name/preloader_emmc_b
    symlink /dev/block/platform/bootdevice/by-name/preloader_a /dev/block/platform/bootdevice/by-name/preloader_ufs_a
    symlink /dev/block/platform/bootdevice/by-name/preloader_b /dev/block/platform/bootdevice/by-name/preloader_ufs_b

    # Support A/B feature for combo emmc and ufs OTA update
    symlink /dev/block/platform/bootdevice/by-name/preloader_a /dev/block/by-name/preloader_emmc_a
    symlink /dev/block/platform/bootdevice/by-name/preloader_b /dev/block/by-name/preloader_emmc_b
    symlink /dev/block/platform/bootdevice/by-name/preloader_a /dev/block/by-name/preloader_ufs_a
    symlink /dev/block/platform/bootdevice/by-name/preloader_b /dev/block/by-name/preloader_ufs_b

    exec u:r:update_engine:s0 root root -- /system/bin/mtk_plpath_utils

    symlink /dev/block/mapper/pl_a /dev/block/by-name/preloader_raw_a
    symlink /dev/block/mapper/pl_b /dev/block/by-name/preloader_raw_b
    symlink /dev/block/mapper/pl_a /dev/block/platform/bootdevice/by-name/preloader_raw_a
    symlink /dev/block/mapper/pl_b /dev/block/platform/bootdevice/by-name/preloader_raw_b
