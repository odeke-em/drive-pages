  <div class="wide">

### About drive

`drive` is a tiny program to pull or push [Google Drive](https://drive.google.com) files.

`drive` was originally developed by [Burcu Dogan](https://github.com/rakyll) while working on the Google Drive team. This repository contains the latest version of the code, as she is no longer able to maintain it.


### Why another Google Drive client?

Background sync is not just hard, it is stupid. My technical and philosophical rants about why it is not worth to implement:

* Too racy. Data has been shared between your remote resource, local disk and sometimes in your sync daemon's in-memory struct. Any party could touch a file any time, hard to lock these actions. You end up working with multiple isolated copies of the same file and trying to determine which is the latest version and should be synced across different contexts.

* It requires great scheduling to perform best with your existing environmental constraints. On the other hand, file attributes has an impact on the sync strategy. Large files are blocking, you wouldn't like to sit on and wait for a VM image to get synced before you start to work on a tiny text file.

* It needs to read your mind to understand your priorities. Which file you need most? It needs to read your mind to foresee your future actions. I'm editing a file, and saving the changes time to time. Why not to wait until I feel confident enough to commit the changes to the remote resource?

`drive` is not a sync daemon, it provides:

* Upstreaming and downstreaming. Unlike a sync command, we provide pull and push actions. User has opportunity to decide what to do with their local copy and when. Do some changes, either push it to remote or revert it to the remote version. Perform these actions with user prompt.

	    $ echo "hello" > hello.txt
	    $ drive push # pushes hello.txt to Google Drive
	    $ echo "more text" >> hello.txt
	    $ drive pull # overwrites the local changes with the remote version

* Allowing to work with a specific file or directory, optionally not recursively. If you recently uploaded a large VM image to Google Drive, yet  only a few text files are required for you to work, simply only push/pull the file you want to work with.

	    $ echo "hello" > hello.txt
	    $ drive push hello.txt # pushes only the specified file
	    $ drive pull path/to/a/b # pulls the remote directory recursively

* Better I/O scheduling. One of the major goals is to provide better scheduling to improve upload/download times.

* Possibility to support multiple accounts. Pull from or push to multiple Google Drive remotes. Possibility to support multiple backends. Why not to push to Dropbox or Box as well?

### Known issues

* Probably, it doesn't work on Windows.
* Google Drive allows a directory to contain files/directories with the same name. Client doesn't handle these cases yet. We don't recommend you to use `drive` if you have such files/directories to avoid data loss.
* Racing conditions occur if remote is being modified while we're trying to update the file. Google Drive provides resource versioning with ETags, use Etags to avoid racy cases.
* drive rejects reading from namedPipes because they could infinitely hang. See [issue #208](https://github.com/odeke-em/drive/issues/208).

### Reach out

Doing anything interesting with drive or want to share your favorite tips and tricks? Check out the [wiki](https://github.com/odeke-em/drive/wiki) and feel free to reach out with ideas for features or requests.

### Disclaimer

This project is not supported nor maintained by Google.

### LICENSE

Copyright 2013 Google Inc. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


  </div>