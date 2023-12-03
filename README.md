# Remove-MCLEAKS

## This is made for Fire's Discord by [@Hectarox](https://discord.com/users/595285763613130759)

[![Join us on Discord](https://invidget.switchblade.xyz/mcalts?theme=dark)](https://discord.gg/mcalts)

# Explanation

This script reverts any modification made by MCLeaks/EasyMC. We've had many complains of players who could not log into Microsoft/Mojang accounts after using MCLeaks/EasyMC and got the error:

**"Failed to login: The authentification servers are currently down for maintenance"**

MCLeaks/EasyMC change the authentication servers from Mojang's to theirs preventing users from logging in into their normal accounts. This could also be caused from malwares that middlemans the Mojang's servers and steals accounts. To repair this, this script cancels out the modifications made by any software on the hosts file located at `C:\Windows\System32\drivers\etc`
This script simply removes the three lines that prevent users from logging in, those are examples and the script automatically detects if other ones exist:
### "x.x.x.x sessionserver.mojang.com"
### "x.x.x.x authserver.mojang.com"
### "x.x.x.x launchermeta.mojang.com"
### THE SCRIPT AUTOMATICALLY REMOVES THE LINES WITH ANY IPS
# Usage

## Automatic Mode (Script in this GitHub)

1. Download the script by [clicking here](https://github.com/berkantdu123/Remove-MCLEAKS/releases/latest/download/execute.bat). 
2. Run as administrator
3. You're good to go!
*(You can find the code to both the [script](https://github.com/berkantdu123/Remove-MCLEAKS/blob/main/reversehosts.ps1) and the [executor](https://github.com/berkantdu123/Remove-MCLEAKS/blob/main/execute.bat) by clicking on their respective names)*
   
## Manual Mode
If you're facing any issues with this script, you can fix the problem manually by doing these simple steps:
1. Open Notepad as administrator.
2. Press Ctrl+O on your keyboard.
3. Navigate to `C:\Windows\System32\drivers\etc`.
4. Now open the hosts file and look for the following lines.
   1. x.x.x.x sessionserver.mojang.com
   2. x.x.x.x authserver.mojang.com
   3. x.x.x.x launchermeta.mojang.com
      <br>
      **The x.x.x.x could be any ip, commonly 127.0.0.1, if not, it could be a virus** <br>
      **/!\ Delete any other lines that contains the word "Mojang" or "Minecraft"**
5. Once you've found them, make sure to delete them.
**MAKE SURE TO SAVE THE FILE AND RESTART YOUR COMPUTER FOR THE CHANGES TO TAKE PLACE**

*If you see other lines containing the word "mojang" make sure to delete them!*

6. Hit Ctrl+S (Save) and now you're good to go!

# Note
This script simply automates the process making it much quicker.

The script also performs a `takeown` on the file to prevent permission issues, which is reverted afterwards to the original owner of the file (e.g SYSTEM).
