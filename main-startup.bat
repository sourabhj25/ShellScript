#batch script to run the Test reporter in Docker container.
#batch for docker start
start /wait  %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -c "C:/Users/agsuser/Desktop/docker-start.bat"
#batch for docker compose up
start /wait %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -c "C:/Users/agsuser/Desktop/reporter-start.bat"


















