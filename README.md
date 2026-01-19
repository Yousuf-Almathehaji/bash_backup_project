# Linux Backup to AWS S3 (Bash Script)

A Bash script that creates a compressed backup of a specified directory on a Linux system,
stores it locally, and uploads a copy to an AWS S3 bucket with logging and error handling.

---

## Features

- 📁 Backup any directory on a Linux system
- 🗜 Create compressed `.tar.gz` backups
- 🗄 Store backups locally
- ☁ Upload backups to AWS S3
- 🕒 Timestamped backup filenames
- 📝 Logging with date and time
- ❌ Stops execution on errors (`set -e`)

---

## Requirements

- Linux OS
- Bash
- AWS CLI installed
- AWS credentials configured (`aws configure`)
- An existing AWS S3 bucket

---

## Project Structure

```text
.
├── script-bkup.sh
├── config.env
├── crontab
└── README.md
