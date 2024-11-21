# Lab #13: ONBUILD Making wedding clothes for others
https://dockerlabs.collabnix.com/beginners/dockerfile/onbuild.html

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
    - [Ubutu Rails](#ubutu-rails)
      - [Create Dockerfile](#create-dockerfile-2)
      - [Building Docker Image](#building-docker-image-2)
      - [Create a downstream image](#create-a-downstream-image-1)
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
Format:
```docker
ONBUILD <other instructions>
```

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

#### Ubutu Rails
See the example here: https://github.com/sangam14/docker_onbuild/tree/master.

##### Create Dockerfile
*Base Dockerfile*:
```docker
FROM ubuntu:12.04

RUN apt-get update -qq && apt-get install -y ca-certificates sudo curl git-core
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN locale-gen  en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN curl -L https://get.rvm.io | bash -s stable
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN /bin/bash -l -c rvm requirements
RUN source /usr/local/rvm/scripts/rvm && rvm install ruby
RUN rvm all do gem install bundler

ONBUILD ADD . /opt/rails_demo
ONBUILD WORKDIR /opt/rails_demo
ONBUILD RUN rvm all do bundle install
ONBUILD CMD rvm all do bundle exec rails server
```

This *Dockerfile* is doing some initial setup of a base image. Installs Ruby and bundler. Pretty typical stuff. At the end are the `ONBUILD` instructions.

- `ONBUILD ADD . /opt/rails_demo` Tells any child image to add everything in the current directory to */opt/railsdemo*. Remember, this only gets run from a child image, that is when another image uses this one as a base (or `FROM`). And it just so happens if you look in the repo I have a skeleton rails app in railsdemo that has it’s own Dockerfile in it, we’ll take a look at this later.

- `ONBUILD WORKDIR /opt/rails_demo` Tells any child image to set the working directory to */opt/rails_demo*, which is where we told `ADD` to put any project files

- `ONBUILD RUN rvm all do bundle install` Tells any child image to have bundler install all gem dependencies, because we are assuming a Rails app here.

- `ONBUILD CMD rvm all do bundle exec rails server` Tells any child image to set the CMD to start the rails server

##### Building Docker Image
Ok, so let’s see this image build, go ahead and do this for yourself so you can see the output.
```sh
git clone git@github.com:sangam14/docker_onbuild.git
cd docker_onbuild
docker build -t sangam14/docker_onbuild .

Step 0 : FROM ubuntu:12.04
 ---&gt; 9cd978db300e
Step 1 : RUN apt-get update -qq &amp;&amp; apt-get install -y ca-certificates sudo curl git-core
 ---&gt; Running in b32a089b7d2d
# output supressed
ldconfig deferred processing now taking place
 ---&gt; d3fdefaed447
Step 2 : RUN rm /bin/sh &amp;&amp; ln -s /bin/bash /bin/sh
 ---&gt; Running in f218cafc54d7
 ---&gt; 21a59f8613e1
Step 3 : RUN locale-gen  en_US.UTF-8
 ---&gt; Running in 0fcd7672ddd5
Generating locales...
done
Generation complete.
 ---&gt; aa1074531047
Step 4 : ENV LANG en_US.UTF-8
 ---&gt; Running in dcf936d57f38
 ---&gt; b9326a787f78
Step 5 : ENV LANGUAGE en_US.UTF-8
 ---&gt; Running in 2133c36335f5
 ---&gt; 3382c53f7f40
Step 6 : ENV LC_ALL en_US.UTF-8
 ---&gt; Running in 83f353aba4c8
 ---&gt; f849fc6bd0cd
Step 7 : RUN curl -L https://get.rvm.io | bash -s stable
 ---&gt; Running in b53cc257d59c
# output supressed
---&gt; 482a9f7ac656
Step 8 : ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
 ---&gt; Running in c4666b639c70
 ---&gt; b5d5c3e25730
Step 9 : RUN /bin/bash -l -c rvm requirements
 ---&gt; Running in 91469dbc25a6
# output supressed
Step 10 : RUN source /usr/local/rvm/scripts/rvm &amp;&amp; rvm install ruby
 ---&gt; Running in cb4cdfcda68f
# output supressed
Step 11 : RUN rvm all do gem install bundler
 ---&gt; Running in 9571104b3b65
Successfully installed bundler-1.5.3
Parsing documentation for bundler-1.5.3
Installing ri documentation for bundler-1.5.3
Done installing documentation for bundler after 3 seconds
1 gem installed
 ---&gt; e2ea33486d62
Step 12 : ONBUILD ADD . /opt/rails_demo
 ---&gt; Running in 5bef85f266a4
 ---&gt; 4082e2a71c7e
Step 13 : ONBUILD WORKDIR /opt/rails_demo
 ---&gt; Running in be1a06c7f9ab
 ---&gt; 23bec71dce21
Step 14 : ONBUILD RUN rvm all do bundle install
 ---&gt; Running in 991da8dc7f61
 ---&gt; 1547bef18de8
Step 15 : ONBUILD CMD rvm all do bundle exec rails server
 ---&gt; Running in c49139e13a0c
 ---&gt; 23c388fb84c1
Successfully built 23c388fb84c1
```

##### Create a downstream image
*Dockerfile*
```docker
FROM cpuguy83/onbuild_demo
```

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
