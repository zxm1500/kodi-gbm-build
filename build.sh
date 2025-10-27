name: Build Kodi GBM for Ubuntu 24.04

on:
  workflow_dispatch:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-24.04

    steps:
    - name: Checkout
      uses: actions/checkout@v4

    - name: Install dependencies
      run: |
        sudo apt update
        sudo apt install -y git build-essential cmake git-core autopoint gettext \
          libtool curl zip unzip libdrm-dev libgbm-dev libfmt-dev libspdlog-dev \
          libfreetype6-dev libfribidi-dev libpcre3-dev libcrossguid-dev \
          libjpeg-dev libpng-dev libtiff-dev libxml2-dev liblzo2-dev libass-dev \
          libssl-dev libmicrohttpd-dev libbluray-dev libdvdnav-dev libdvdread-dev \
          libcurl4-openssl-dev libcdio-dev libsamplerate0-dev libpulse-dev \
          libinput-dev libudev-dev libxrandr-dev libegl1-mesa-dev libgles2-mesa-dev \
          mesa-utils python3-dev python3-pil python3-setuptools python3-distutils

    - name: Clone Kodi
      run: |
        git clone --branch master https://github.com/xbmc/xbmc.git
        cd xbmc
        git submodule update --init --recursive

    - name: Build Kodi GBM
      run: |
        cd xbmc
        mkdir -p build
        cd build
        cmake .. -DCMAKE_BUILD_TYPE=Release -DCORE_PLATFORM_NAME=gbm -DAPP_RENDER_SYSTEM=gles
        make -j$(nproc)

    - name: Package .deb
      run: |
        cd xbmc/build
        cpack -G DEB
        mkdir -p ../../artifacts
        mv *.deb ../../artifacts/

    - name: Upload artifact
      uses: actions/upload-artifact@v4
      with:
        name: kodi-gbm
        path: artifacts/*.deb
