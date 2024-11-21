#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles

# Writing a Dockerfile with SHELL instruction
content="
FROM windowsservercore\n
\n
# Executed as cmd /S /C echo default\n
RUN echo default\n
\n
# Executed as cmd /S /C powershell -command Write-Host default\n
RUN powershell -command Write-Host default\n
\n
# Executed as powershell -command Write-Host hello\n
SHELL [\"powershell\", \"-command\"]\n
RUN Write-Host hello\n
\n
# Executed as cmd /S /C echo hello\n
SHELL [\"cmd\", \"/S\", \"/C\"]\n
RUN echo hello\n
"

echo -en "" $content | sed 's/ //' > Dockerfile
