# VPN Protocol Speed Test Automation Tool

An automated benchmarking utility designed to test, log, and analyze the performance of various VPN protocols (such as WireGuard and OpenVPN) against your base internet connection. 

This tool automates sequential testing cycles using the official **Ookla Speedtest CLI** and parses comprehensive network metrics into a clean, structured CSV file for deep analytical review.

---

## 🚀 Live Benchmarks & Transparency
We actively utilize this automated script to generate objective data for our comprehensive VPN performance reviews and comparison charts. You can view our live test results, methodologies, and top VPN recommendations directly on our platform:

👉 **[Hangisi Alınmalı - VPN Performance & Reviews](https://hangisialinmali.com)**

---

## ✨ Features
* **Protocol Labeling:** Supports pre-configured tags for Base (No VPN), OpenVPN UDP, OpenVPN TCP, WireGuard, or custom manual tags.
* **Automated Batch Testing:** Runs a cycle of 6 sequential tests with built-in 5-minute (300-second) cooldown intervals to prevent rate-limiting and ensure accuracy.
* **Comprehensive Metrics:** Captures Idle Ping, Jitter, Download/Upload speeds (converted to Mbps), Download/Upload Loaded Latency (IQM), Packet Loss, Server Details, ISP, and the official Result URL.
* **Structured Data Export:** Automatically creates and appends data into `speedtest_sonuclar.csv` using a clean semicolon-delimited tabular format.

---

## 📋 Prerequisites
1. **Speedtest CLI Binary:** * Download the official command-line tool from [Ookla Speedtest CLI](https://www.speedtest.net/apps/cli).
   * Extract and place the `speedtest.exe` file inside the exact same directory as this script.
2. **Windows PowerShell:** * Requires PowerShell v1.0 or higher (built into modern Windows environments) to handle JSON parsing.

---

## 🛠️ Installation & Usage

1. **Clone or Download** this repository to your local Windows machine.
2. Ensure `speedtest.bat`, `parse.ps1`, and the downloaded `speedtest.exe` are all located in the **same folder**.
3. Double-click `speedtest.bat` to launch the interactive script.
4. Select your active VPN protocol from the console menu (Options 1-5).
5. Leave the window open. The script will autonomously run for 30 minutes, output live summaries to the console, and safely write the structured dataset to `speedtest_sonuclar.csv`.

---

## 📊 Output Schema
The generated CSV file logs the following header layout for seamless importing into Microsoft Excel, Google Sheets, or Python Pandas:
`Protokol;Test_No;Tarih_Saat;Idle_Ping_ms;Jitter_ms;Indirme_Mbps;DL_Latency_ms;Yukleme_Mbps;UL_Latency_ms;Packet_Loss;Sunucu;ISP;Result_URL`

---

## 📜 License
This project is open-source and available under the [MIT License](LICENSE). Feel free to modify, fork, or adapt it for your personal or commercial benchmarking workflows.