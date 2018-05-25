FROM microsoft/windowsservercore
SHELL ["powershell"]

RUN Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
RUN choco install -y googlechrome

EXPOSE 9222
ADD StartUp.ps1 /StartUp.ps1
CMD  C:\\StartUp.ps1