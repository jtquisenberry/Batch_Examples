@echo off
setlocal enabledelayedexpansion 


set path[0]="www.google.com"
set path[1]="www.gamefaqs.com"
set path[2]="www.bing.com"


for /l %%n in (0,1,3) do ( 
   echo !path[%%n]! 
   "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "!path[%%n]!"
)