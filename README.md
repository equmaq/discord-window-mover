# Discord window mover

A script that automatically moves Discord to your secondary monitor on startup

# Usage

Download MoveDiscord.vbs and move the file to "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup" 
aka (C:\Users\<user_account>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup)

This will run the script on Windows startup

# Extra notes

I don't recommend using this if you don't have Discord set to run at startup, as this will result in a PowerShell script running in the background until you open Discord.

Might not work properly if you have Discord set to a language other than English.

# Modification guide

If you have Discord set to something other than English, you can fix this by replacing "'Discord Updater'" on line 37 of the script with the equivalent in your language.

To find out what that is, simply close Discord, disconnect your internet, and open Discord again. 
Then hover over Discord in your taskbar and look at what the window title is.
