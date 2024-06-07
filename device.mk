#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/xiaomi/evergo

# Project ID Quota
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)


# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-impl.recovery \
    bootctrl.mt6833 \
    bootctrl.mt6833.recovery \
    android.hardware.boot@1.0-service

PRODUCT_PACKAGES += \
    bootctrl.mt6833

# Crypto
PRODUCT_VENDOR_PROPERTIES += \
    ro.crypto.volume.filenames_mode=aes-256-cts

# Kernel
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)-kernel/Image.gz:kernel

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service-recovery \
    android.hardware.gatekeeper@1.0-impl-recovery

PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.gatekeeper=beanpod

# Health
PRODUCT_PACKAGES += \
   android.hardware.health@2.1-impl \
   android.hardware.health@2.1-service

# Keymaster
TARGET_RECOVERY_DEVICE_MODULES += \
    libkeymaster4 \
    libkeymaster41 \
    libpuresoftkeymasterdevice

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster41.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpuresoftkeymasterdevice.so

PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.kmsetkey=beanpod

# Ramdisk
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt6833:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.mt6833
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# TEE
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.mtk_microtrust_tee_support=1 \
    ro.vendor.mtk_svp_on_mtee_support=1 \
    ro.vendor.mtk_tee_gp_support=1

# USB
PRODUCT_SYSTEM_PROPERTIES += \
    ro.sys.usb.storage.type=mtp


 VNDK
PRODUCT_TARGET_VNDK_VERSION := 31

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 30