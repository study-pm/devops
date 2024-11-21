#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles

# Writing a Standard Dockerfile
default="
# Use the official Ubuntu image as the base\n
FROM ubuntu:20.04\n
\n
# Print the UID and GID\n
CMD sh -c \"echo 'Inside Container:' && echo 'User: \$(whoami) UID: \$(id -u) GID: \$(id -g)'\"\n
"

echo -en "" $default | sed 's/ //' > build1.Dockerfile

# Writing a Dockerfile with USER instruction
custom="
# Use the official Ubuntu image as the base\n
FROM ubuntu:20.04\n
\n
# Create a custom user with UID 1234 and GID 1234\n
RUN groupadd -g 1234 customgroup && \ \n
\tuseradd -m -u 1234 -g customgroup customuser\n
\n
# Switch to the custom user\n
USER customuser\n
\n
# Set the workdir\n
WORKDIR /home/customuser\n
\n
# Print the UID and GID\n
CMD sh -c \"echo 'Inside Container:' && echo 'User: \$(whoami) UID: \$(id -u) GID: \$(id -g)'\"\n
"

echo -en "" $custom | sed 's/ //' > build2.Dockerfile
