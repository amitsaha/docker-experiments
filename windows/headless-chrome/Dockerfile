FROM amitsaha/chocolatey
RUN choco install -y googlechrome

EXPOSE 9222
ADD StartUp.ps1 /StartUp.ps1
CMD  C:\\StartUp.ps1