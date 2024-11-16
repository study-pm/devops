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
