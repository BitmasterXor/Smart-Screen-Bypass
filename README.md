This project demonstrates how to add and remove Zone IDs to ensure a PE Binary (.EXE) can run without triggering Microsoft Windows Smart Screen.

**Key Points to Consider:**
- Zone ID #3 (Internet Zone) triggers SmartScreen.
- When a file is downloaded from the internet, it is flagged with Zone ID 3.
- Removing or modifying this Zone ID can prevent SmartScreen from being triggered, allowing the executable to run smoothly.
