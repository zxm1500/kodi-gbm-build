# Kodi GBM Build Template

This repository builds **Kodi (GBM mode)** for **Ubuntu Server 24.04 (x86_64)**  
No Xorg required — runs directly on framebuffer with DRM/GBM + GLES.

## 💡 Usage

1. Fork this repository
2. Go to **Actions** → Run “Build Kodi GBM”
3. Wait for the build to finish
4. Download the `.deb` from “Artifacts”

## 🧰 Run locally
```bash
chmod +x build.sh
./build.sh
