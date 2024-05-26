#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common twrp stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from evergo device
$(call inherit-product, device/xiaomi/evergo/device.mk)

PRODUCT_DEVICE := evergo
PRODUCT_NAME := twrp_evergo
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := evergo
PRODUCT_MANUFACTURER := xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="evergo-user 12 SP1A.210812.016 V816.0.1.0.TGBINXM release-keys"

BUILD_FINGERPRINT := Redmi/evergo/evergo:12/SP1A.210812.016/V816.0.1.0.TGBINXM:user/release-keys
