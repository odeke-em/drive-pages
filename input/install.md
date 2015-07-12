  <div class="wide">
### Requirements

go 1.3.X or higher is required. See [here](https://golang.org/doc/install) for installation instructions and platform installers.

# Make sure to set your GOPATH in your env, .bashrc or .bash\_profile file. If you have not yet set it, you can do so like this:

```
$ cat << ! >> ~/.bashrc
```

```
$ export GOPATH=\$HOME/gopath
```

```
$ export PATH=\$GOPATH:\$GOPATH/bin:\$PATH
```

```
$ source ~/.bashrc 
```

# To reload the settings and get the newly set ones Or open a fresh terminal

The above setup will ensure that the drive binary after compilation can be invoked from your current path.

### Installation

To install from the latest source, run:

```
$ go get -u github.com/odeke-em/drive/cmd/drive
```

Otherwise:

* In order to address [issue #138](https://github.com/odeke-em/drive/issues/138), where debug information should be bundled with the binary, you'll need to run:

```
$ go get github.com/odeke-em/drive/drive-gen && drive-gen
```

In case you need a specific binary e.g for Debian folks [issue #271](https://github.com/odeke-em/drive/issues/271) and [issue 277](https://github.com/odeke-em/drive/issues/277)

```
$ go get -u github.com/odeke-em/drive/drive-google
```

That should produce a binary `drive-google`

OR

To bundle debug information with the binary, you can run:

```
$ go get -u github.com/odeke-em/drive/drive/drive-gen && drive-gen drive-google
```


### Godep

+ Using godep
```
$ cd $GOPATH/src/github.com/odeke-em/drive/drive-gen && godep save
```

+ Unravelling/Restoring dependencies
```
$ cd $GOPATH/src/github.com/odeke-em/drive/drive-gen && godep restore
```

Please see file `drive-gen/README.md` for more information.


### Platform Specific Installation Methods
Is your platform missing a package? Feel free to prepare / contribute an installation package and then submit a PR to add it in.


### Arch Linux or Arch based distros.
#This includes Arch linux, Antergos, Manjaro, etc. [List](https://wiki.archlinux.org/index.php/Arch_based_distributions_(active))

```
$ yaourt -S drive
```

Since drive is in the aur, you will need an aur helper such as yaourt above. If you are not fimilar with
a helper, you can find a list [here](https://wiki.archlinux.org/index.php/AUR_helpers#AUR_search.2Fbuild_helpers)


### Ubuntu, or Ubuntu based distros. 
#This includes Ubuntu, Mint, Linux Lite, etc. [List](http://distrowatch.com/search.php?basedon=Ubuntu)

```
$ sudo add-apt-repository ppa:twodopeshaggy/drive
```

```
$ sudo apt-get update
```

```
$ sudo apt-get install drive
```

### openSUSE distro. (may also work with fedora, CentOS, Red Hat)

# Install needed software tools
```
$ sudo yum install go mercurial git hg-git
```

```
$ mkdir $HOME/go
```

```
$ export GOPATH=$HOME/go
```
# For convenience, add the workspace's bin subdirectory to your PATH:
```
$ export PATH=$PATH:$GOPATH/bin
```

# Get and compile the drive program
```
$ go get github.com/odeke-em/drive/cmd/drive
```

# Run drive with this command:
```
$ $GOPATH/bin/drive
```

  </div>

