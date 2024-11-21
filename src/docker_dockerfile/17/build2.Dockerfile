# Use the official Ubuntu image as the base
FROM ubuntu:20.04

# Create a custom user with UID 1234 and GID 1234
RUN groupadd -g 1234 customgroup && \
	useradd -m -u 1234 -g customgroup customuser

# Switch to the custom user
USER customuser

# Set the workdir
WORKDIR /home/customuser

# Print the UID and GID
CMD sh -c "echo 'Inside Container:' && echo 'User: $(whoami) UID: $(id -u) GID: $(id -g)'"
