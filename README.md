<div align="center">

# ⚡ VIDOWNLOAD

  <p align="center">
    <strong>Skrip CLI Video Downloader</strong>
    <br />
    <br />
    <a href="#-key-features">Key Features</a> •
    <a href="#-system-requirements">Requirements</a> •
    <a href="#-installation">Installation</a> •
    <a href="#-usage">Usage</a> •
    <a href="#-troubleshooting">Troubleshooting</a>
  </p>

  ![Aria2](https://img.shields.io/badge/Downloader-Aria2c-000000?style=for-the-badge)
  ![yt-dlp](https://img.shields.io/badge/Extractor-yt--dlp-red?style=for-the-badge)
  ![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

</div>

<img width="1080" height="2400" alt="1001358663" src="https://github.com/user-attachments/assets/8e62e3dc-0e85-4da8-85b0-63dff5605d8d" />

<img width="1080" height="2400" alt="1001358662" src="https://github.com/user-attachments/assets/c783277c-c5ed-40a0-b1fd-c0cbc5edcf5f" />

---

## Description

**Vidownload** (`Video Downloader`) Interactive perl script to to download videos from video stream website pages.

---

## Key Features

- **Multi-Threaded Acceleration**: Uses 16 parallel connections via `aria2c` for maximum download speed.
- **Quality & Size Options**: Flexible choices for video quality (360p, 480p, 720p, or Best) to save storage space and data.
- **Anti-Block & DNS Bypass**: Automatically provides DNS resolvers (Cloudflare `1.1.1.1` / Google `8.8.8.8`) and sends headers (User-Agent & Referer) to avoid server blocking.
---

## System Requirements

- **OS**: Termux (Android) or Linux Distribution (Ubuntu, Debian, Arch, etc.
- **Dependencies**: `perl`, `python`, `aria2`, `ffmpeg`, `python-yt-dlp`, `yt-dlp-ejs` `(Will be automatically checked & installed by the installer script)`
  
---

## Installation

1. **Clone / Download this repository** to your device:
```
git clone https://github.com/iksan757/Vidownload.git
cd Vidownload/assets/

perl install.pl

```
