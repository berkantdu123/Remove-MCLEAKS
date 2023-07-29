# Remove-MCLEAKS

# This is made for Fire's Discord by @hectarox

This script reverts any modification made by mcleaks. We've had many complains of players who could not log into microsoft accounts after using mcleaks and got the error **"Failed to login: The authentification servers are currently down for maintenance" **
Mcleaks prevents users from logging in into their normal account, to repair this, this script cancels out the modifications made by the software on the hosts file located at "C:\Windows\System32\drivers\etc"
This script simply removes the two lines that prevent users from logging in:
### "127.0.0.1 sessionserver.mojang.com"
### "127.0.0.1 authserver.mojang.com"

If you're facing any issues with this script, you can still change the hosts file manually, to do so:
1. Open notepad as administrator
2. Do Ctrl+O
3. Navigate to C:\Windows\System32\drivers\etc
4. Now edit the host file and remove those following lines:
   127.0.0.1 sessionserver.mojang.com
   127.0.0.1 authserver.mojang.com
5. Hit Ctrl+S (Save) and now you're good to go!
   
This script simply automates the process making it much quicker.
