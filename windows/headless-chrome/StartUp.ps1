& ${Env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe --headless --disable-gpu --remote-debugging-address=0.0.0.0 --remote-debugging-port=9222 --no-sandbox https://www.chromestatus.com
While($true)
{ 
   $i++
}