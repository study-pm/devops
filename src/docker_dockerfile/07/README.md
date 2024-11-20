# Lab #7: RUN instruction
https://dockerlabs.collabnix.com/beginners/dockerfile/Lab%237_RUN_instruction.html

The `RUN` instruction execute command on top of the below layer and create a new layer.

- [Assignment](#assignment)
- [Command Line Tools](#command-line-tools)
  - [Start the service](#start-the-service)
  - [Stop the service](#stop-the-service)
  - [Underlying commands](#underlying-commands)
    - [Pre-requisite](#pre-requisite)
    - [Create an image with `RUN` instruction](#create-an-image-with-run-instruction)
      - [Create Dockerfile](#create-dockerfile)
      - [Building Docker image](#building-docker-image)
      - [Checking layer of the image](#checking-layer-of-the-image)
      - [Checking image size](#checking-image-size)
    - [Combining multiple `RUN` instruction to one](#combining-multiple-run-instruction-to-one)
      - [Create Dockerfile](#create-dockerfile-1)
      - [Building Docker image](#building-docker-image-1)
      - [Checking layer of the image](#checking-layer-of-the-image-1)
      - [Checking image size](#checking-image-size-1)
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
- [Troubleshooting](#troubleshooting)
  - [Fix `permission denied` error](#fix-permission-denied-error)
  - [Fix `failed to read dockerfile` error](#fix-failed-to-read-dockerfile-error)


`RUN` instruction can be wrote in two forms:

- `RUN` (**shell form**)
- `RUN` [“executable”, “param1”, “param2”] (**exec form**)

## Assignment
- Create an image with `RUN` instruction
- Combining multiple `RUN` instruction to one

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
There should be the following files (committed) in your working directory:
- *build1.Dockerfile*
- *build2.Dockerfile*

In case any of them missing, run the *[create.sh](./create.sh)* script before executing the *start* command.

#### Create an image with `RUN` instruction

##### Create Dockerfile
*Dockerfile*
```docker
FROM alpine:3.9.3
LABEL maintainer="Collabnix"
RUN apk add --update
RUN apk add curl
RUN rm -rf /var/cache/apk/
```

Placed into *[create.sh](./create.sh)*.

##### Building Docker image

```sh
$ docker image build -t run:v1 .
```

Placed into *[build.sh](./build.sh)*.

##### Checking layer of the image

```sh
$  docker image history run:v1
IMAGE               CREATED             CREATED BY                                      SIZE
NT
5b09d7ba1736        19 seconds ago      /bin/sh -c rm -rf /var/cache/apk/               0B
192115cc597a        21 seconds ago      /bin/sh -c apk add curl                         1.55MB
0518580850f1        43 seconds ago      /bin/sh -c apk add --update                     1.33MB
8590497d994e        45 seconds ago      /bin/sh -c #(nop)  LABEL maintainer=Collabnix   0B
cdf98d1859c1        4 months ago        /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B
<missing>           4 months ago        /bin/sh -c #(nop) ADD file:2e3a37883f56a4a27…   5.53MB
```

Number of layers 6

Placed into *[history.sh](./history.sh)*.

##### Checking image size

```sh
$ docker image ls run:v1
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
run
```

Its 8.42MB

Placed into *[verify.sh](./verify.sh)*.

#### Combining multiple `RUN` instruction to one

##### Create Dockerfile
*Dockerfile*:
```docker
FROM alpine:3.9.3
LABEL maintainer="Collabnix"
RUN apk add --update && \
	apk add curl  && \
	rm -rf /var/cache/apk/
```

Placed into *[create.sh](./create.sh)*.

##### Building Docker image

```sh
$ docker image build -t run:v2 .
```

Placed into *[build.sh](./build.sh)*.

##### Checking layer of the image

```sh
$ docker image history run:v2
IMAGE               CREATED             CREATED BY                                      SIZE
NT
784298155541        50 seconds ago      /bin/sh -c apk add --update  && apk add curl…   1.55MB
8590497d994e        8 minutes ago       /bin/sh -c #(nop)  LABEL maintainer=Collabnix   0B
cdf98d1859c1        4 months ago        /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B
<missing>           4 months ago        /bin/sh -c #(nop) ADD file:2e3a37883f56a4a27…   5.53MB
```

Number of layers 4

Placed into *[run.sh](./run.sh)*.

##### Checking image size

```sh
$ docker image ls run:v2
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
run                 v2                  784298155541        3 minutes ago       7.08MB
```

it's now 7.08MB

Placed into *[verify.sh](./verify.sh)*.

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
$ docker container run <container>
$ docker run <container>
```

#### List containers
```sh
# List running containers
$ docker ps
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