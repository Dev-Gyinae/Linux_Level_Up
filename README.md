# Linux_Level_Up

Project 1: Network Packet Monitoring (packet_stats.sh)
-------------------------------------------------------------------
This script monitors network traffic on a specific port for 3 seconds and reports the number of packets transmitted. Useful for checking active connections, debugging services, or monitoring suspicious activity.

sudo ./port_monitor.sh PORT_NUMBER eg.  sudo ./port_monitor.sh 8080

![image](https://github.com/user-attachments/assets/296622cb-1486-4e7c-a01c-0ffb939e882a)


(Root access is necessary because of TCPdumps scanning)

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

Project 2: Password Generator (genpass.sh) 
-----------------------------------------------------------------------
This Bash script generates strong, random 12-character passwords that meet the following security requirements:
  * At least 1 digit (0-9)
  * At least 1 lowercase letter (a-z)
  * At least 1 uppercase letter (A-Z)
  * At least 1 special character (!@#$%^&*_+-=...)

![image](https://github.com/user-attachments/assets/1ffd1fd2-631d-41d2-89e8-b4cc355f561d)

-----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------- 

Project 3: Archive Files (Easy Auditing of files)
-----------------------------------------------------------------------
This script archives log files from a specified directory within a given date range (YYYY-MM-DD to YYYY-MM-DD), automatically organizing them into a dated folder at /tmp for audit purposes, while preserving the original directory structure.

eg. $ sudo ./archive_files_by_date.sh /var/log/nginx 2024-01-01 2025-01-01 </br>
       sudo [script] [target directory] [from: date] [to: date]

![image](https://github.com/user-attachments/assets/08aad6b5-b71e-497f-9c2e-6275c1aa0608)


-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------

Project 4: Backup Cron 2.0
-----------------------------------------------------------------------

This project sets up a daily cron job at 2 AM to back up log files from /var/log/ to /backups/ in a compressed .tar.gz archive.

Key Features:
✅ Automatic Daily Backups

Runs via cron at 2 AM
Saves to /backups/logs_YYYYMMDD.tar.gz (dated filename)

Includes:
* System logs (syslog, auth.log, kern.log, etc.)
* Application logs (*.log in /var/log/)

✅ Manual Execution Option

* Run on-demand backups with progress display
*  Shows exactly which files are copied

![image](https://github.com/user-attachments/assets/43b2070e-bf0e-4e3e-ac0d-0fcc9094744b)
![image](https://github.com/user-attachments/assets/fbc26926-99f1-4918-acc4-0e0295491bb3)
![image](https://github.com/user-attachments/assets/ed724ef4-b862-4844-ba9c-38f838c8ad17)

✅ Easy Setup
Installs cron if missing

<i> Self-contained script with interactive menu <i/>

-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------

