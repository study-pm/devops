# Lab #13: ONBUILD Making wedding clothes for others
https://dockerlabs.collabnix.com/beginners/dockerfile/onbuild.html

Format: `ONBUILD <other instructions>`.

- [Overview](#overview)
- [Assignment](#assignment)
- [Command Line Tools](#command-line-tools)
  - [Start the service](#start-the-service)
  - [Stop the service](#stop-the-service)
  - [Underlying commands](#underlying-commands)
    - [Pre-requisite](#pre-requisite)
    - [Create an image with `ONBUILD` instruction](#create-an-image-with-onbuild-instruction)
      - [Create Dockerfile](#create-dockerfile)
      - [Building Docker Image](#building-docker-image)
    - [Create a downstream image](#create-a-downstream-image)
      - [Create Dockerfile](#create-dockerfile-1)
      - [Building Docker Image](#building-docker-image-1)
- [Utils / Trivia](#utils--trivia)
  - [Images](#images)
    - [Build image](#build-image)
    - [Browse image history](#browse-image-history)
    - [Remove images](#remove-images)
  - [Containers](#containers)
    - [Create (run) a container](#create-run-a-container)
    - [List containers](#list-containers)
    - [Exit the container shell](#exit-the-container-shell)
    - [Remove containers](#remove-containers)
    - [Remove a container](#remove-a-container)
    - [Force-remove a running container (`--force`)](#force-remove-a-running-container---force)
    - [Remove all stopped containers](#remove-all-stopped-containers)
  - [Volumes](#volumes)
    - [Create a volume](#create-a-volume)
    - [List volumes](#list-volumes)
    - [Inspect volume](#inspect-volume)
    - [Remove volumes](#remove-volumes)
- [Troubleshooting](#troubleshooting)
  - [Fix `permission denied` error](#fix-permission-denied-error)
  - [Fix `failed to read dockerfile` error](#fix-failed-to-read-dockerfile-error)

## Overview
`ONBUILD` is a special instruction, followed by other instructions, such as `RUN`, `COPY`, etc., and these instructions will not be executed when the current image is built. Only when the current image is mirrored, the next level of mirroring will be executed.

The other instructions in *Dockerfile* are prepared to customize the current image. Only `ONBUILD` is prepared to help others customize themselves.

Suppose we want to make an image of the application written by Node.js. We all know that Node.js uses *npm* for package management, and all dependencies, configuration, startup information, etc. are placed in the `package.json` file. After getting the program code, you need to do `npm install` first to get all the required dependencies. Then you can start the app with `npm start`. Therefore, in general, *Dockerfile* will be written like this:
```docker
FROM node:slim
RUN mkdir /app
WORKDIR /app
COPY ./package.json /app
RUN [ "npm", "install" ]
COPY . /app/
CMD [ "npm", "start" ]
```

Put this *Dockerfile* in the root directory of the Node.js project, and after building the image, you can use it to start the container. But what if we have a second Node.js project? Ok, then copy this *Dockerfile* to the second project. If there is a third project? Copy it again? The more copies of a file, the more difficult it is to have version control, so let’s continue to look at the maintenance of such scenarios.

If the first Node.js project is in development, I find that there is a problem in this *Dockerfile*, such as typing a typo, or installing an extra package, then the developer fixes the *Dockerfile*, builds it again, and solves the problem. The first project is ok, but the second one? Although the original *Dockerfile* was copied and pasted from the first project, it will not fix their *Dockerfile* because the first project, and the Dockerfile of the second project will be automatically fixed.

So can we make a base image, and then use the base image for each project? In this way, the basic image is updated, and each project does not need to synchronize the changes of *Dockerfile*. After rebuilding, it inherits the update of the base image. Ok, yes, let’s see the result. Then the above *Dockerfile* will become:
```docker
FROM node:slim
RUN mkdir /app
WORKDIR /app
CMD [ "npm", "start" ]
```

Here we take out the project-related build instructions and put them in the subproject. Assuming that the name of the base image is `my-node`, the own *Dockerfile* in each project becomes:
```docker
FROM my-node
```

Yes, there is only one such line. When constructing a mirror with this one-line *Dockerfile* in each project directory, the three lines of the previous base image `ONBUILD` will start executing, successfully copy the current project code into the image, and execute for this project. `npm install`, generate an application image.

## Assignment
- Create a base image ("parent") with `ONBUILD` instruction
- Create a downstream image ("child") from the base one
- Build the images to see the `ONBUILD` triggers running when building the downstream image

## Command Line Tools
There are two prime commands for managing (starting and stopping) the provided service.

### Start the service
The following command runs the full command sequence:
```sh
$ ./start
```

alternatively:
```sh
$ sh start
```

### Stop the service
The following command clears all of the output (removing all possible side-effects) generated by running the *start* command:
```sh
$ ./clear
```

alternatively:
```sh
$ sh clear
```

### Underlying commands
There are multiple underlying scripts used for building the service functions. The sections below describe the commands used for managing the provided service and building the necessary resources.

#### Pre-requisite
There should be the following files in your working directory:
- *base.Dockerfile* (committed)
- *downstream.Dockerfile* (committed)

In case any of them missing, run the *[create.sh](./create.sh)* script before executing the *start* command.

All temporary files are removed on running the *[clear.sh](./clear.sh)* script

#### Create an image with `ONBUILD` instruction

##### Create Dockerfile

*Dockerfile*
```docker
FROM busybox
ONBUILD RUN echo "You won't see me until later"
```

Placed into *[create.sh](./create.sh)*.

##### Building Docker Image

```sh
$ docker build -t me/no_echo_here .
```
Here the `ONBUILD` instruction is read, not run, but stored for later use.

Placed into *[build.sh](./build.sh)*.

#### Create a downstream image

##### Create Dockerfile

*Dockerfile*
```docker
FROM me/no_echo_here
```

Placed into *[create.sh](./create.sh)*.

##### Building Docker Image

```sh
$ docker build -t me/echo_here .
```

Placed into *[build.sh](./build.sh)*.

## Utils / Trivia

### Images

#### Build image
```sh
$ docker image build -t <tag> .
$ docker build -t <tag> . -f <dockerfile-name>
```

#### Browse image history
```sh
$ docker image history <image>

#### List images
```sh
# Lists all images
$ docker images
$ docker image ls

# List a specific image
$ docker images <image>
$ docker image ls <image>
$ docker images | grep "keyword(s)"
```

#### Remove images
Below are the three command aliases:
```sh
$ docker image remove <image>
$ docker image rm <image>
$ docker rmi <image>
```

### Containers

#### Create (run) a container
```sh
$ docker container run <image>
$ docker run <image>
```

#### List containers
```sh
# List running containers
$ docker ps
$ docker container ls

# Lists all (running and stopped) containers
$ docker ps -a
```

#### Exit the container shell
Press <kbd>Ctrl</kbd> + <kbd>c</kbd> to exit the container shell. This stops the running container.

If you want to detach from a container without stopping it, type <kbd>Ctrl</kbd> + <kbd>p</kbd> then <kbd>Ctrl</kbd> + <kbd>q</kbd>. It will help you to turn interactive mode to daemon mode.

#### Remove containers
https://docs.docker.com/reference/cli/docker/container/rm/

#### Remove a container
This removes the container referenced under the link `/redis`.
```sh
$ docker rm /redis

/redis
```

#### Force-remove a running container (`--force`)
This command force-removes a running container.
```sh
$ docker rm --force redis

redis
```

The main process inside the container referenced under the link `redis` will receive `SIGKILL`, then the container will be removed.

#### Remove all stopped containers
Use the [`docker container prune`](https://docs.docker.com/reference/cli/docker/container/prune/) command to remove all stopped containers, or refer to the [`docker system prune`](https://docs.docker.com/reference/cli/docker/system/prune/) command to remove unused containers in addition to other Docker resources, such as (unused) images and networks.

Alternatively, you can use the `docker ps` with the `-q` / `--quiet` option to generate a list of container IDs to remove, and use that list as argument for the `docker rm` command.

Combining commands can be more flexible, but is less portable as it depends on features provided by the shell, and the exact syntax may differ depending on what shell is used. To use this approach on Windows, consider using PowerShell or Bash.

The example below uses `docker ps -q` to print the IDs of all containers that have exited (`--filter status=exited`), and removes those containers with the `docker rm` command:
```sh
$ docker rm $(docker ps --filter status=exited -q)
```

Or, using the `xargs` Linux utility:
```sh
$ docker ps --filter status=exited -q | xargs docker rm
```

### Volumes
https://docs.docker.com/reference/cli/docker/volume/

Manage volumes. Usage: `docker volume COMMAND`

#### Create a volume
```sh
$ docker volume create
```

#### List volumes

```sh
$ docker volume ls
```

Show names and mount point destinations of volumes used by a container:
https://stackoverflow.com/questions/30133664/how-do-you-list-volumes-in-docker-containers

```sh
$ docker container inspect \
 -f '{{ range .Mounts }}{{ .Name }}:{{ .Destination }} {{ end }}' \
 <CONTAINER_ID_OR_NAME>
```

#### Inspect volume

```sh
$ docker volume inspect
```

#### Remove volumes
Remove unused local volumes:
```sh
# With confirmation dialogue
$ docker volume prune

# Without confirmation
$ docker volume prune -f
```

Remove one or more volumes:
```sh
$ docker volume rm <volumes>
```

## Troubleshooting

### Fix `permission denied` error
If you get the *permission denied* error while building the service scripts, make the script file executable:
```sh
$ chmod +x start
```

or:
```
$ chmod u+x clear
```

### Fix `failed to read dockerfile` error
If you get the *ERROR: failed to solve: failed to read dockerfile* error while running the service, probably you have your *Dockerfile* or other crucial static files missing. Run the *[create.sh](./create.sh)* script before executing the *start* command.
