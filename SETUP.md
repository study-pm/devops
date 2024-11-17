# Setup

- [Overview](#overview)
  - [About this file](#about-this-file)
- [Prerequisites](#prerequisites)
  - [Adding root privileges to user](#adding-root-privileges-to-user)
  - [Utils](#utils)
    - [Neofetch](#neofetch)
    - [cURL](#curl)
    - [Wget](#wget)
    - [Zsh](#zsh)
      - [Install Zsh](#install-zsh)
      - [Oh My Zsh](#oh-my-zsh)
  - [Git](#git)
    - [Linux](#linux)
    - [Windows](#windows)
      - [Using installer](#using-installer)
      - [Using winget tool](#using-winget-tool)
- [Code editor](#code-editor)
  - [Visual Studio Code](#visual-studio-code)
    - [Donwload package](#donwload-package)
    - [Install with flatpack](#install-with-flatpack)
- [PostgreSQL](#postgresql)
  - [Installation instructions for RedOS](#installation-instructions-for-redos)
  - [Key moments](#key-moments)
  - [Extra options](#extra-options)
  - [Troubleshooting](#troubleshooting)
      - [Installation methods](#installation-methods)
        - [Install using the `apt` repository](#install-using-the-apt-repository)
        - [Upgrade Docker Engine](#upgrade-docker-engine)
        - [Install from a package](#install-from-a-package)
        - [Upgrade Docker Engine](#upgrade-docker-engine-1)
        - [Install using the convenience script](#install-using-the-convenience-script)
        - [Install pre-releases](#install-pre-releases)
        - [Upgrade Docker after using the convenience script](#upgrade-docker-after-using-the-convenience-script)
  - [Uninstall Docker Engine](#uninstall-docker-engine)
  - [Linux post-installation steps for Docker Engine](#linux-post-installation-steps-for-docker-engine)
    - [Manage Docker as a non-root user](#manage-docker-as-a-non-root-user)
    - [Configure Docker to start on boot with systemd](#configure-docker-to-start-on-boot-with-systemd)
    - [Configure default logging driver](#configure-default-logging-driver)
- [Fetch code](#fetch-code)

## Overview

### About this file
This file provides detailed setup instructions for developers and maintainers, such as fetching the source code, managing the dependencies, setting up environments, build generation, running tests etc.

> **Note**: Any dependencies added to this project (or modifying it) which affect the running of the code in this git repository must be listed in this file. All developers must ensure that the instructions mentioned in this file are sufficient to enable a new developer to obtain an executable/runnable/working copy of the lastest code in this repository, without involvement from any other human assistance.

## Prerequisites
Before fetching and installing the project you must have the appropriate working environment. The project can be operated on Linux or Windows systems and requires some special software.

### Adding root privileges to user
Consider the user named `student`. Add the following line to the *sudoers* file: `student ALL = (ALL) ALL`.

```sh
$ echo "student ALL = (ALL) ALL" >> /etc/sudoers
```

or

```sh
$ echo "student ALL = (ALL:ALL) ALL" >> /etc/sudoers
```

What is the difference between the two?

```
root ALL=(ALL:ALL) ALL
```

https://askubuntu.com/questions/546219/what-is-the-difference-between-root-all-allall-all-and-root-all-all-all

- The first field indicates the username that the rule will apply to (`root`).

- First “ALL” indicates that this rule applies to all hosts.

- Second “ALL” indicates that the root user can run commands as all users.

- Third “ALL” indicates that the root user can run commands as all groups.

- Forth “ALL” indicates these rules apply to all commands.

### Utils

#### Neofetch
https://github.com/dylanaraps/neofetch

**Neofetch** is a command-line system information tool written in `bash 3.2+`. Neofetch displays information about your operating system, software and hardware in an aesthetic and visually pleasing way.

The overall purpose of Neofetch is to be used in screen-shots of your system. Neofetch shows the information other people want to see. There are other tools available for proper system statistic/diagnostics.

The information by default is displayed alongside your operating system's logo. You can further configure Neofetch to instead use an image, a custom ASCII file, your wallpaper or nothing at all.

Installation command (RedOS):
```sh
$ dnf install neofetch
```

Check if a program is installed:
```sh
$ neofetch --version
```

Usage:
```sh
$ neofetch
```

#### cURL
https://curl.se/

**cURL** is a command line tool (**curl**) and library (**libcurl**) for transferring data with URLs (since 1998). curl is used in command lines or scripts to transfer data using various network protocols. The name stands for "Client for URL".

Installation command (RedOS):
```sh
$ dnf install curl
```

Check if a program is installed:
```sh
$ curl --version
```

#### Wget
https://www.gnu.org/software/wget/

**GNU Wget** is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS, the most widely used Internet protocols. It is a non-interactive commandline tool, so it may easily be called from scripts, cron jobs, terminals without X-Windows support, etc.

Installation command (RedOS):
```sh
$ dnf install wget
```

Check if a program is installed:
```sh
$ wget --version
```

#### Zsh
https://www.zsh.org/

**Zsh** is a shell designed for interactive use, although it is also a powerful scripting language.

##### Install Zsh

Follow these steps to install Zsh:
https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH

1. There are two main ways to install Zsh:

   - With the package manager of your choice, e.g. `sudo apt install zsh` (see [here for more examples](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#how-to-install-zsh-on-many-platforms))
   - From [source](https://zsh.sourceforge.io/Arc/source.html), following [the instructions from the Zsh FAQ](https://zsh.sourceforge.io/FAQ/zshfaq01.html#l7).

2. Verify installation by running `zsh --version`. Expected result: `zsh 5.0.8` or more recent.

3. Make it your default shell: `chsh -s $(which zsh)` or use `sudo lchsh $USER` if you are on Fedora.

- Note that this will not work if Zsh is not in your authorized shells list (`/etc/shells`) or if you don't have permission to use `chsh`. If that's the case [you'll need to use a different procedure](https://www.google.com/search?q=zsh+default+without+chsh).
- If you use `lchsh` you need to type `/bin/zsh` to make it your default shell.

4. Log out and log back in again to use your new default shell.

5. Test that it worked with `echo $SHELL`. Expected result: `/bin/zsh` or similar.

6. Test with `$SHELL --version`. Expected result: 'zsh 5.8' or similar

Install on Ubuntu, Debian & derivatives (Windows 10 WSL | Native Linux kernel with Windows 10 build 1903):
```sh
$ apt install zsh
```

If you don't have `apt`, the recommended package manager for end users, you can try `apt-get` or `aptitude`.

[Other distributions that apply](https://en.wikipedia.org/wiki/List_of_Linux_distributions#Debian-based) include: Linux Mint, elementary OS, Zorin OS, Raspbian, MX Linux, Deepin.

Install on Fedora/RHEL/RedOS:
```sh
$ dnf install zsh
```

##### Oh My Zsh
https://ohmyz.sh/

**Oh My Zsh** is a delightful, open source, community-driven framework for managing your Zsh configuration.

- In order for **Oh My Zsh** to work, **Zsh must be installed**.
  - Please run `zsh --version` to confirm.
  - Expected result: `zsh 5.0.8` or more recent
- Additionally, Zsh should be set as your default shell.
  - Please run `echo $SHELL` from a new terminal to confirm.
  - Expected result: `/usr/bin/zsh` or similar

Oh My Zsh is installed by running one of the following commands in your terminal. You can install this via the command-line with either curl or wget.

Install oh-my-zsh via curl:
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install oh-my-zsh via wget:
```sh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

### Git
Git is necessary to fetch, commit and deliver the source code. Detailed setup instructions are layed down on the [official git site](https://git-scm.com/downloads).

#### Linux
It is easiest to install Git on Linux using the preferred package manager of your Linux distribution. Go https://git-scm.com/download/linux and follow the setup instructions.

For the latest stable version for your release of Debian/Ubuntu
```
# apt-get install git
```
For Ubuntu, this PPA provides the latest stable upstream Git version
```
# add-apt-repository ppa:git-core/ppa # apt update; apt install git
```

Installation command for RHEL/Fedora/RedOS:
```sh
$ dnf install git
```

To check the git version use any of the following commands:
- `git --version`
- `git -v`

#### Windows
Follow the setup instructions on https://git-scm.com/download/win.

##### Using installer
You can download git for Windows from installer from https://git-scm.com/download/win. Choose a compatible version. We recommend using Git Bash standalone for Windows.

##### Using winget tool
Install winget tool if you don't already have it, then type this command in command prompt or Powershell.
```ps
$ winget install --id Git.Git -e --source winget
```

## Code editor
Install any code editor to browse the repo and documentation. We recommend using the Microsoft Visual Studio Code which is free and available for all the most popular systems &mdash; Windows, macOS and Linux.

### Visual Studio Code

#### Donwload package

You can donwload and install the appropriate package for your system at the official page: https://code.visualstudio.com/.

#### Install with flatpack
https://redos.red-soft.ru/base/redos-7_3/7_3-development/7_3-ide/7_3-visual-studio-code/?nocache=1731766975842

To install in RedOS with flatpack you have to install flatpack first (see  [the details here](https://redos.red-soft.ru/base/redos-7_3/7_3-administation/7_3-isolated-env/7_3-flatpak/?nocache=1731766990407))
```sh
$ sudo dnf install flatpak
```

Add the required repository (see [the details here](https://redos.red-soft.ru/base/redos-7_3/7_3-administation/7_3-isolated-env/7_3-flatpak/#add?nocache=1731773127306)).

Add flathub repo:
```sh
$ flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

Add Gnome repo:
```sh
$ flatpak remote-add --user --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
```

Add KDE repo:
```sh
$ flatpak remote-add --user --if-not-exists kdeapps --from https://distribute.kde.org/kdeapps.flatpakrepo
```

List all added repositories:
```sh
$ flatpak remotes

 Name       Параметры
 flathub    user
```

The next step would be installing vscode from flathub:
```sh
$ flatpak install flathub com.visualstudio.code
```

Wait for completion. After that you will be able to run the application:
```sh
$ flatpak run com.visualstudio.code
```

Check vscode version:
```sh
$ code --version
```

or:
```sh
$ code -v
```

## PostgreSQL
**PostgreSQL** is a powerful, open source object-relational database that is available for download as ready-to-use packages or installers for various platforms, as well as a source code archive if you want to build it yourself. Go to the [official download page](https://www.postgresql.org/download/) to get the installation instructions considering your specific case.

### Installation instructions for RedOS
https://redos.red-soft.ru/base/redos-7_3/7_3-administation/7_3-smdb-in-ro/7_3-install-postgresql/?nocache=1731858553637

1. Switch to the root mode

   ```sh
   $ su -
   ```

2. Run the installation command.

    > **Note**: Number 15 in the examples below stands for the PostgreSQL version. Versions 12, 13, 14, 15, 16 are available via RedOS repositories. Default version (comes without number) is 12.

    ```sh
    dnf install postgresql15-server
    ```

3. Initialize the database.

   ```sh
   postgresql-15-setup initdb
   ```

4. After successful initialization run the **`postgresql`** service. To start a service at boot use the enable command.

   ```sh
   systemctl enable postgresql-15.service --now
   ```

5. Make sure the service is up and running.

    ```sh
    systemctl status postgresql-15.service
    ```

    You should see the **`active (running)`** status.

6. Check the current version

    ```sh
    $ psql --version
    ```

    alternatively:
    ```sh
    $ psql -V
    ```

    or:
    ```sh
    $ pg_config --version
    ```

    It will show the current server version. To check the client version authorize as the `postgres` user, run the postgress shell (see below) and execute the `psql -V` command again.

### Key moments

Authorize as the **`postgres`** user:
```sh
su - postgres
```

To run the **postgres shell** (can be run with a **`postgres`** user only) execute the following command:
```sh
psql
```

Get the database list:
```sh
\l
```

Get the table list:
```sh
\dt *
```

Exit the **postgress shell**:
```sh
\q
```

Exit the current **postgres** account:
```sh
exit
```

### Extra options
You can plug in the **`contrib`** catalogue to extend the **PostgreSQL** functions. It contains extra modules for porting, analysis, additional functions that aren not included in the standard package.

!!! danger Important

    These modules are experimental and targeted to the restricted audience.

To plug in the **`contrib`** catalogue run:
```sh
$ dnf install postgresql15-contrib
```

### Troubleshooting
If you cannot connect to PostgreSQL via `pgadmin4` follow these steps:

1. Open the ***postgresql.conf*** file for editing:

   ```sh
   $ nano /var/lib/pgsql/15/data/postgresql.conf
   ```

2. Replace the string:

   ```sh
   # listen_addresses = 'localhost'
   ```

   with the following one:
   ```sh
   listen_addresses = '*'
   ```

3. Put the following config at the top of the ***/var/lib/pgsql/15/data/pg_hba.conf*** file (should be a first string of the file):

   ```sh
   host all all 0.0.0.0/0 md5
   ```

    This parameter allows access to all databases for all users with encrypted passwords.

4. Assign a password to the **`postgres`** user for remote database administration:

   ```sh
    su - postgres
    psql
    ALTER USER postgres WITH ENCRYPTED PASSWORD 'yourpassword';
    ```

    where `yourpassword` stands for the password you set.

5. To apply the changes you must restart the **`postgresql`** service:

    ```sh
    $ systemctl restart postgresql-15.service
    ```

## Docker
https://docs.docker.com/get-started/get-docker/

Docker is an open platform for developing, shipping, and running applications. You can download and install Docker on multiple platforms. The easiest way is to install Docker Desktop for you operating system. Alternatively you can install Docker Engine. Refer to the following section and choose the best installation path for you.

### Install Docker Desktop
Follow these instructions considering your system type:

- [Install Docker Desktop on Mac](https://docs.docker.com/desktop/setup/install/mac-install/): a native application using the macOS sandbox security model that delivers all Docker tools to your Mac
- [Install Docker Desktop on Windows](https://docs.docker.com/desktop/setup/install/windows-install/): a native Windows application that delivers all Docker tools to your Windows computer.
- [Install Docker Desktop on Linux](https://docs.docker.com/desktop/setup/install/linux/): a native Linux application that delivers all Docker tools to your Linux computer.

### Install Docker Engine

#### Install Docker Engine on Ubuntu
https://docs.docker.com/engine/install/ubuntu/

To get started with Docker Engine on Ubuntu, make sure you [meet the prerequisites](#prerequisites-1), and then follow the [installation steps](#installation-methods).

##### Prerequisites

###### Firewall limitations

!!! warning Warning

    Before you install Docker, make sure you consider the following security implications and firewall incompatibilities.

- If you use ufw or firewalld to manage firewall settings, be aware that when you expose container ports using Docker, these ports bypass your firewall rules. For more information, refer to [Docker and ufw](https://docs.docker.com/engine/network/packet-filtering-firewalls/#docker-and-ufw).
- Docker is only compatible with `iptables-nft` and `iptables-legacy`. Firewall rules created with `nft` are not supported on a system with Docker installed. Make sure that any firewall rulesets you use are created with `iptables` or `ip6tables`, and that you add them to the `DOCKER-USER` chain, see [Packet filtering and firewalls](https://docs.docker.com/engine/network/packet-filtering-firewalls/).

###### OS requirements
To install Docker Engine, you need the 64-bit version of one of these Ubuntu versions:

- Ubuntu Oracular 24.10
- Ubuntu Noble 24.04 (LTS)
- Ubuntu Jammy 22.04 (LTS)
- Ubuntu Focal 20.04 (LTS)

Docker Engine for Ubuntu is compatible with x86_64 (or amd64), armhf, arm64, s390x, and ppc64le (ppc64el) architectures.

###### Uninstall old versions
Before you can install Docker Engine, you need to uninstall any conflicting packages.

Your Linux distribution may provide unofficial Docker packages, which may conflict with the official packages provided by Docker. You must uninstall these packages before you install the official version of Docker Engine.

The unofficial packages to uninstall are:

- `docker.io`
- `docker-compose`
- `docker-compose-v2`
- `docker-doc`
- `podman-docker`

Moreover, Docker Engine depends on `containerd` and `runc`. Docker Engine bundles these dependencies as one bundle: `containerd.io`. If you have installed the `containerd` or `runc` previously, uninstall them to avoid conflicts with the versions bundled with Docker Engine.

Run the following command to uninstall all conflicting packages:
```sh
$ for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

`apt-get` might report that you have none of these packages installed.

Images, containers, volumes, and networks stored in */var/lib/docker/* aren't automatically removed when you uninstall Docker. If you want to start with a clean installation, and prefer to clean up any existing data, read the [uninstall Docker Engine section](https://docs.docker.com/engine/install/ubuntu/#uninstall-docker-engine).

##### Installation methods
You can install Docker Engine in different ways, depending on your needs:

- Docker Engine comes bundled with [Docker Desktop for Linux](https://docs.docker.com/desktop/setup/install/linux/). This is the easiest and quickest way to get started.

- Set up and install Docker Engine from [Docker's apt repository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

- [Install it manually](https://docs.docker.com/engine/install/ubuntu/#install-from-a-package) and manage upgrades manually.

- Use a [convenience script](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script). Only recommended for testing and development environments.

###### Install using the `apt` repository
Before you install Docker Engine for the first time on a new host machine, you need to set up the Docker `apt` repository. Afterward, you can install and update Docker from the repository.

1. Set up Docker's apt repository.

   ```sh
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    ```

    !!! info Note

        ❗If you use an Ubuntu derivative distribution, such as Linux Mint, you may need to use `UBUNTU_CODENAME` instead of `VERSION_CODENAME`.


    ```sh
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$UBUNTU_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    ```
2. Install the Docker packages.

   To install the latest version, run:
   ```sh
   $ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
   ```

   To install a specific version of Docker Engine, start by listing the available versions in the repository:
   ```sh
    # List the available versions:
    $ apt-cache madison docker-ce | awk '{ print $3 }'

    5:27.3.1-1~ubuntu.24.04~noble
    5:27.3.0-1~ubuntu.24.04~noble
    ...
    ```

    Select the desired version and install:
    ```sh
    $ VERSION_STRING=5:27.3.1-1~ubuntu.24.04~noble
    $ sudo apt-get install docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-buildx-plugin docker-compose-plugin
    ```

3. Verify that the installation is successful by running the `hello-world` image:

   ```sh
   $ sudo docker run hello-world
   ```

   This command downloads a test image and runs it in a container. When the container runs, it prints a confirmation message and exits.

4. Check out the Docker version:

    ```sh
    $ docker -v
    Docker version 27.3.1, build ce12230

    $ docker --version
    Docker version 27.3.1, build ce12230

    $ viktor@viktor-MS-7D99:~$ docker version
    Client: Docker Engine - Community
    Version:           27.3.1
    API version:       1.47
    Go version:        go1.22.7
    Git commit:        ce12230
    Built:             Fri Sep 20 11:40:59 2024
    OS/Arch:           linux/amd64
    Context:           default

    Server: Docker Engine - Community
    Engine:
      Version:          27.3.1
      API version:      1.47 (minimum version 1.24)
      Go version:       go1.22.7
      Git commit:       41ca978
      Built:            Fri Sep 20 11:40:59 2024
      OS/Arch:          linux/amd64
      Experimental:     false
    containerd:
      Version:          1.7.23
      GitCommit:        57f17b0a6295a39009d861b89e3b3b87b005ca27
    runc:
      Version:          1.1.14
      GitCommit:        v1.1.14-0-g2c9f560
    docker-init:
      Version:          0.19.0
      GitCommit:        de40ad0
    ```

You have now successfully installed and started Docker Engine.

!!! tip Tip

    **Receiving errors when trying to run without root?**

    The `docker` user group exists but contains no users, which is why you’re required to use `sudo` to run Docker commands. Continue to Linux postinstall to allow non-privileged users to run Docker commands and for other optional configuration steps.

###### Upgrade Docker Engine
To upgrade Docker Engine, follow step 2 of the [installation instructions](#install-using-the-apt-repository), choosing the new version you want to install.

###### Install from a package
If you can't use Docker's `apt` repository to install Docker Engine, you can download the `deb` file for your release and install it manually. You need to download a new file each time you want to upgrade Docker Engine.

1. Go to https://download.docker.com/linux/ubuntu/dists/.

2. Select your Ubuntu version in the list.

3. Go to *pool/stable/* and select the applicable architecture (`amd64`, `armhf`, `arm64`, or `s390x`).

4. Download the following deb files for the Docker Engine, CLI, containerd, and Docker Compose packages:

- `containerd.io_<version>_<arch>.deb`
- `docker-ce_<version>_<arch>.deb`
- `docker-ce-cli_<version>_<arch>.deb`
- `docker-buildx-plugin_<version>_<arch>.deb`
- `docker-compose-plugin_<version>_<arch>.deb`

5. Install the `.deb` packages. Update the paths in the following example to where you downloaded the Docker packages.

    ```sh
    $ sudo dpkg -i ./containerd.io_<version>_<arch>.deb \
      ./docker-ce_<version>_<arch>.deb \
      ./docker-ce-cli_<version>_<arch>.deb \
      ./docker-buildx-plugin_<version>_<arch>.deb \
      ./docker-compose-plugin_<version>_<arch>.deb
    ```

    The Docker daemon starts automatically.

6. Verify that the installation is successful by running the `hello-world` image:

    ```sh
    $ sudo service docker start
    $ sudo docker run hello-world
    ```

    This command downloads a test image and runs it in a container. When the container runs, it prints a confirmation message and exits.

You have now successfully installed and started Docker Engine.

!!! tip Tip

    **Receiving errors when trying to run without root?**

    The docker `user` group exists but contains no users, which is why you’re required to use `sudo` to run Docker commands. Continue to Linux postinstall to allow non-privileged users to run Docker commands and for other optional configuration steps.



The docker user group exists but contains no users, which is why you’re required to use sudo to run Docker commands. Continue to [Linux postinstall](#linux-post-installation-steps-for-docker-engine) to allow non-privileged users to run Docker commands and for other optional configuration steps.

###### Upgrade Docker Engine
To upgrade Docker Engine, download the newer package files and repeat the [installation procedure](#install-from-a-package), pointing to the new files.

###### Install using the convenience script
Docker provides a convenience script at https://get.docker.com/ to install Docker into development environments non-interactively. The convenience script isn't recommended for production environments, but it's useful for creating a provisioning script tailored to your needs. Also refer to the [install using the repository]((#install-using-the-apt-repository)) steps to learn about installation steps to install using the package repository. The source code for the script is open source, and you can find it in the [`docker-install` repository on GitHub](https://github.com/docker/docker-install).

Always examine scripts downloaded from the internet before running them locally. Before installing, make yourself familiar with potential risks and limitations of the convenience script:

- The script requires `root` or `sudo` privileges to run.
- The script attempts to detect your Linux distribution and version and configure your package management system for you.
- The script doesn't allow you to customize most installation parameters.
- The script installs dependencies and recommendations without asking for confirmation. This may install a large number of packages, depending on the current configuration of your host machine.
- By default, the script installs the latest stable release of Docker, containerd, and runc. When using this script to provision a machine, this may result in unexpected major version upgrades of Docker. Always test upgrades in a test environment before deploying to your production systems.
- The script isn't designed to upgrade an existing Docker installation. When using the script to update an existing installation, dependencies may not be updated to the expected version, resulting in outdated versions.

!!! tip Tip

    Preview script steps before running. You can run the script with the `--dry-run` option to learn what steps the script will run when invoked:
    ```sh
    $ curl -fsSL https://get.docker.com -o get-docker.sh
    $ sudo sh ./get-docker.sh --dry-run
    ```

This example downloads the script from https://get.docker.com/ and runs it to install the latest stable release of Docker on Linux:
```sh
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh
Executing docker install script, commit: 7cae5f8b0decc17d6571f9f52eb840fbc13b2737
<...>
```

You have now successfully installed and started Docker Engine. The `docker` service starts automatically on Debian based distributions. On `RPM` based distributions, such as CentOS, Fedora, RHEL or SLES, you need to start it manually using the appropriate `systemctl` or `service` command. As the message indicates, non-root users can't run Docker commands by default.

> **Use Docker as a non-privileged user, or install in rootless mode?**
>
> The installation script requires `root` or `sudo` privileges to install and use Docker. If you want to grant non-root users access to Docker, refer to the [post-installation steps for Linux](#linux-post-installation-steps-for-docker-engine). You can also install Docker without `root` privileges, or configured to run in rootless mode. For instructions on running Docker in rootless mode, refer to r[un the Docker daemon as a non-root user (rootless mode)](https://docs.docker.com/engine/security/rootless/).

###### Install pre-releases
Docker also provides a convenience script at https://test.docker.com/ to install pre-releases of Docker on Linux. This script is equal to the script at `get.docker.com`, but configures your package manager to use the test channel of the Docker package repository. The test channel includes both stable and pre-releases (beta versions, release-candidates) of Docker. Use this script to get early access to new releases, and to evaluate them in a testing environment before they're released as stable.

To install the latest version of Docker on Linux from the test channel, run:

```sh
$ curl -fsSL https://test.docker.com -o test-docker.sh
$ sudo sh test-docker.sh
```

###### Upgrade Docker after using the convenience script
If you installed Docker using the convenience script, you should upgrade Docker using your package manager directly. There's no advantage to re-running the convenience script. Re-running it can cause issues if it attempts to re-install repositories which already exist on the host machine.

### Uninstall Docker Engine
1. Uninstall the Docker Engine, CLI, containerd, and Docker Compose packages:

    ```
    $ sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
    ```

2. Images, containers, volumes, or custom configuration files on your host aren't automatically removed. To delete all images, containers, and volumes:

    ```sh
    $ sudo rm -rf /var/lib/docker
    $ sudo rm -rf /var/lib/containerd
    ```

3. Remove source list and keyrings

    ```sh
    $ sudo rm /etc/apt/sources.list.d/docker.list
    $ sudo rm /etc/apt/keyrings/docker.asc
    ```

You have to delete any edited configuration files manually.

### Linux post-installation steps for Docker Engine
https://docs.docker.com/engine/install/linux-postinstall/

These optional post-installation procedures describe how to configure your Linux host machine to work better with Docker.

#### Manage Docker as a non-root user
The Docker daemon binds to a Unix socket, not a TCP port. By default it's the `root` user that owns the Unix socket, and other users can only access it using `sudo`. The Docker daemon always runs as the `root` user.

If you don't want to preface the `docker` command with `sudo`, create a Unix group called `docker` and add users to it. When the Docker daemon starts, it creates a Unix socket accessible by members of the `docker` group. On some Linux distributions, the system automatically creates this group when installing Docker Engine using a package manager. In that case, there is no need for you to manually create the group.

!!! warning Warning

    The `docker` group grants root-level privileges to the user. For details on how this impacts security in your system, see [Docker Daemon Attack Surface](https://docs.docker.com/engine/security/#docker-daemon-attack-surface).

!!! info Note

    To run Docker without root privileges, see [Run the Docker daemon as a non-root user (Rootless mode)](https://docs.docker.com/engine/security/rootless/).

To create the docker group and add your user:

1. First, check if the docker group is already exists:
   ```sh
   $ cat /etc/group | grep docker
   docker:x:986:
   ```

   alternatively:
   ```sh
    $ getent group | grep docker
    docker:x:986:
    ```


2. Create the docker group (if it doesn't exist).
    ```sh
    $ sudo groupadd docker
    ```

3. Add your user to the `docker` group.

   ```sh
   $ sudo usermod -aG docker $USER
   ```

4. Check out the members of the `docker` group.

   ```sh
    $ awk -F':' '/docker/{print $4}' /etc/group
    viktor
    ```

    List all groups for specific user:
    ```sh
    $ groups $USER
    viktor : viktor adm cdrom sudo dip plugdev users lpadmin sambashare docker
    ````

5. Log out and log back in so that your group membership is re-evaluated.

    > If you're running Linux in a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.

    You can also run the following command to activate the changes to groups:

    ```sh
    $ newgrp docker
    ```

5. Verify that you can run docker commands without sudo.

    ```sh
    $ docker run hello-world
    ```

    This command downloads a test image and runs it in a container. When the container runs, it prints a message and exits.

If you initially ran Docker CLI commands using `sudo` before adding your user to the docker group, you may see the following error:

```
WARNING: Error loading config file: /home/user/.docker/config.json -
stat /home/user/.docker/config.json: permission denied
```

This error indicates that the permission settings for the `~/.docker/` directory are incorrect, due to having used the `sudo` command earlier.

To fix this problem, either remove the `~/.docker/` directory (it's recreated automatically, but any custom settings are lost), or change its ownership and permissions using the following commands:

```sh
$ sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
$ sudo chmod g+rwx "$HOME/.docker" -R
```

#### Configure Docker to start on boot with systemd
Many modern Linux distributions use [systemd](https://systemd.io/) to manage which services start when the system boots. On Debian and Ubuntu, the Docker service starts on boot by default. To automatically start Docker and containerd on boot for other Linux distributions using systemd, run the following commands:
```sh
$ sudo systemctl enable docker.service
$ sudo systemctl enable containerd.service
```

To stop this behavior, use `disable` instead.

```sh
$ sudo systemctl disable docker.service
$ sudo systemctl disable containerd.service
```

You can use systemd unit files to configure the Docker service on startup, for example to add an HTTP proxy, set a different directory or partition for the Docker runtime files, or other customizations. For an example, see C[onfigure the daemon to use a proxy](https://docs.docker.com/engine/daemon/proxy/#systemd-unit-file).

#### Configure default logging driver
Docker provides [logging drivers](https://docs.docker.com/engine/logging/) for collecting and viewing log data from all containers running on a host. The default logging driver, `json-file`, writes log data to JSON-formatted files on the host filesystem. Over time, these log files expand in size, leading to potential exhaustion of disk resources.

To avoid issues with overusing disk for log data, consider one of the following options:

- Configure the `json-file` logging driver to turn on [log rotation](https://docs.docker.com/engine/logging/drivers/json-file/).
- Use an [alternative logging driver](https://docs.docker.com/engine/logging/configure/#configure-the-default-logging-driver) such as the ["local" logging driver](https://docs.docker.com/engine/logging/drivers/local/) that performs log rotation by default.
- Use a logging driver that sends logs to a remote logging aggregator.

## Fetch code
1. Use `git clone` command to fetch the source code from a remote repository. Using `--recurse-submodules` option will automatically initialize and update each submodule in the repository, including nested submodules if any of the submodules in the repository have submodules themselves.

    ```sh
    $ git clone --recurse-submodules  git@gitlab.com:<project-group>/<project-name>.git
    ```

    > ❗ Don't forget to prepend the domain with your account name if you have multiple git accounts:

    ```sh
    $ git clone --recurse-submodules git@dev-pm.git@gitlab.com:<project-group>/<project-name>.git
    ```

2. Change into the project's root folder:

    ```sh
    $ cd <project-name>
    ```

3. To also initialize, fetch and checkout any nested submodules, you can use the foolproof `git submodule update --init --recursive`:

    ```sh
    $ git submodule update --init --recursive
    ```

    > If you want the submodules merged with remote branch automatically, use `--merge` or `--rebase` with `--remote` option. Otherwise all submodules will be in the `DETACHED HEAD` state:

    ```sh
    $ git submodule update --init --recursive --remote --merge
    ```
