# nuke-temp-folder
A script to deep delete (bottom up-approach) a folder of your chosing

## Setup
1. Download scripts
2. Unblock scripts
3. Save somewhere™
4. Create your temp folder if it doesn't exist
5. Run the CreateScheduledTask script to automatically create a scheduled task:
   ```powershell
   .\CreateScheduledTask.ps1 -ScriptPath "C:\path\to\nukeTempFolder.ps1" -TempFolderPath "C:\your\temp\folder"
   ```
## Disclaimers

**Security Warning**: Automatically scheduled scripts can be dangerous as they run with predefined privileges. attackers might be able to execute malicious scripts with higher privliges if permissions are not set correctly throughout your system.

**Data Loss Warning**: This script permanently deletes files and folders. We are not liable for any lost data resulting from the use of this script. Proceed with caution
