#!/bin/bash

base64 -d device/xiaomi/alioth/configs/camera/secret > device/xiaomi/alioth/configs/camera/st_license.lic

# Clone kernel_xiaomi_sm8250
git clone -b magictime-new https://github.com/TIMISONG-dev/kernel_xiaomi_sm8250.git kernel/xiaomi/sm8250 --depth 1 && cd kernel/xiaomi/sm8250 && sed -i '/kernelsu/d' drivers/Kconfig && sed -i 's/s64 teo_wfi_timeout_ns(void);/#ifdef CONFIG_CPU_IDLE_GOV_TEO\ns64 teo_wfi_timeout_ns(void);\n#else\nstatic inline s64 teo_wfi_timeout_ns(void) { return 0; }\n#endif/' arch/arm64/kernel/process.c && cd - > /dev/null

# Clone hardware_xiaomi
git clone https://github.com/PixelOS-AOSP/android_hardware_xiaomi.git hardware/xiaomi -b seventeen --depth 1

# Clone hardware_dolby
git clone https://github.com/oplus-kona/hardware_dolby.git hardware/dolby -b sony-A17 --depth 1


# Clone vendor_xiaomi_alioth
git clone https://github.com/zenzer0s/android_vendor_xiaomi_alioth.git vendor/xiaomi/alioth -b main --depth 1

# Clone packages_apps_GameBar
git clone https://github.com/kenway214/packages_apps_GameBar.git packages/apps/GameBar --depth 1 && sed -i 's/type gamebar_app, domain;/type gamebar_app, domain, coredomain;/' packages/apps/GameBar/sepolicy/public/gamebar_app.te

# Clone vendor_xiaomi_camera
git clone https://gitlab.com/johnmart19/vendor_xiaomi_camera vendor/xiaomi/camera -b aosp-16 --depth 1

sed -i '/vendor\/xiaomi\/sm8250-common/d' vendor/xiaomi/camera/Android.bp

# Clone device_xiaomi_camera
git clone https://github.com/PocoF3Releases/device_xiaomi_camera device/xiaomi/camera -b aosp-16 --depth 1


# Clone vendor_infinity-priv_keys
git clone https://github.com/ProjectInfinity-X/vendor_infinity-priv_keys vendor/infinity-priv/keys --depth 1


# Apply Binder threadpool patch
cd system/libhwbinder
git fetch https://github.com/custom-crdroid/system_libhwbinder.git d9d46e78cec0d09498fd5890eed9f7195baed0fd
git cherry-pick d9d46e78cec0d09498fd5890eed9f7195baed0fd
cd - > /dev/null
