  <div class="wide">
### Configuration

Optionally set the `GOOGLE_API_CLIENT_ID` and `GOOGLE_API_CLIENT_SECRET` environment variables to use your own API keys.

### Usage

# Initializing

Before you can use `drive`, you need to mount your Google Drive directory on your local file system:


`$ drive init ~/gdrive`

`$ cd ~/gdrive`


### Pulling

The `pull` command downloads data from Google Drive that does not exist locally, and deletes local data that is not present on Google Drive. 
Run it without any arguments to pull all of the files from the current path:


`
$ drive pull
`

Pulling by matches is also supported

```
$ cd ~/myDrive/content/2015
```

```
$ drive pull --matches vines docx
```

To force download from paths that otherwise would be marked with no-changes

```
$ drive pull -force
```

To pull specific files or directories, pass in one or more paths:

```
$ drive pull photos/img001.png docs
```

Pulling by id is also supported

```
$ drive pull --id 0fM9rt0Yc9RTPaDdsNzg1dXVjM0E 0fM9rt0Yc9RTPaTVGc1pzODN1NjQ 0fM9rt0Yc9RTPV1NaNFp5WlV3dlU
```


# Note: Checksum verification:

* By default checksum-ing is turned off because it was deemed to be quite vigorous and unnecessary for most cases.
* Due to popular demand to cover the common case in which size + modTime differences are sufficient to detect file changes. The discussion stemmed from issue [#117](https://github.com/odeke-em/drive/issues/117).

   To turn checksum verification back on:

```
$ drive pull -ignore-checksum=false
```


drive also supports piping pulled content to stdout which can be accomplished by:

```
$ drive pull -piped path1 path2
```

#### Exporting Docs

By default, the `pull` command will export Google Docs documents as PDF files. To specify other formats, use the `-export` option:

```
$ drive pull -export pdf,rtf,docx,txt
```

To explicitly export instead of using `--force`

```
$ drive pull --export pdf,rtf,docx,txt --explicitly-export
```

By default, the exported files will be placed in a new directory suffixed by `_exports` in the same path. To export the files to a different directory, use the `-export-dir` option:

```
$ drive pull -export pdf,rtf,docx,txt -export-dir ~/Desktop/exports
```

**Supported formats:**

* doc, docx
* jpeg, jpg
* gif
* html
* odt
* rtf
* pdf
* png
* ppt, pptx
* svg
* txt, text
* xls, xlsx

### Pushing

The `push` command uploads data to Google Drive to mirror data stored locally.

Like `pull`, you can run it without any arguments to push all of the files from the current path, or you can pass in one or more paths to push specific files or directories.

Note: To ignore checksum verification during a push:

```
$ drive push -ignore-checksum
```

drive also supports pushing content piped from stdin which can be accomplished by:

```
$ drive push -piped path
```

+ Note:
  * In relation to [#107](https://github.com/odeke-em/drive/issues/107) and numerous other issues related to confusion about clashing paths, drive will abort on trying to deal with clashing names. To turn off this safety, pass in flag `--ignore-name-clash`.
  * In relation to [#57](https://github.com/odeke-em/drive/issues/57) and [@rakyll's #49](https://github.com/rakyll/drive/issues/49).
   A couple of scenarios in which data was getting totally clobbered and unrecoverable, drive now tries to play it safe and warn you if your data could potentially be lost e.g during a to-disk clobber for which you have no backup. At least with a push you have the luxury of untrashing content. To disable this safety, run drive with flag `-ignore-conflict` e.g:

    
    `$ drive pull -ignore-conflict collaboration_documents`
    

    Playing the safety card even more, if you want to get changes that are non clobberable ie only additions
    run drive with flag `-no-clobber` e.g:

    
    `$ drive pull -no-clobber Makefile`
    

  * Ordinarily your system will not traverse nested symlinks e.g:
  
    `$ mkdir -p a/b`

    `$ mkdir -p ~/Desktop/z1/z2 && ls ~ > ~/Desktop/z1/z2/listing.txt`

    `$ ln -s ~/Desktop/z1/z2 a/b`

    `$ ls -R a` # Should print only z2 and nothing inside it. 
  

    However in relation to [#80](https://github.com/odeke-em/drive/issues/80), for purposes of consistency with your Drive, traversing symlinks has been added.

For safety with non clobberable changes i.e only additions:

```
$ drive push -no-clobber
```

+ Due to the reasons above, drive should be able to warn you in case of total clobbers on data. To turn off this behaviour/safety, pass in the `-ignore-conflict` flag i.e:

```
$ drive push -force sure_of_content
```

To pull without user input (i.e. without prompt)

```
$ drive push -quiet
```

or

```
$ drive push -no-prompt
```

To get Google Drive to convert a file to its native Google Docs format

```
$ drive push -convert
```

Extra features: to make Google Drive attempt Optical Character Recognition (OCR) for png, gif, pdf and jpg files.

```
$ drive push -ocr
```

Note: To use OCR, your account should have this feature. You can find out if your account has OCR allowed.

```
$ drive features
```

# Note:

+ MimeType inference is from the file's extension.

  If you would like to coerce a certain mimeType that you'd prefer to assert with Google Drive pushes, use flag `-coerce-mime <short-key>`

```
$ drive push -coerce-mime docx my_test_doc
```

+ Excluding certain operations can be done both for pull and push by passing in flag
`--exclude-ops` <csv_crud_values>

e.g

```
$ drive pull --exclude-ops "delete,update" vines
```

```
$ drive push --exclude-ops "create" sensitive_files
```

### Publishing

The `pub` command publishes a file or directory globally so that anyone can view it on the web using the link returned.

```
$ drive pub photos
```

+ Publishing by fileId is also supported

```
$ drive pub --id 0fM9rt0Yc9RTPV1NaNFp5WlV3dlU 0fM9rt0Yc9RTPSTZEanBsamZjUXM
```

### Unpublishing

The `unpub` command is the opposite of `pub`. It unpublishes a previously published file or directory.

```
$ drive unpub photos
```

+ Publishing by fileId is also supported

```
$ drive unpub --id 0fM9rt0Yc9RTPV1NaNFp5WlV3dlU 0fM9rt0Yc9RTPSTZEanBsamZjUXM
```

### Sharing and Emailing

The `share` command enables you to share a set of files with specific users and assign them specific roles as well as specific generic access to the files. It also allows for email notifications on share.

```
$ drive share -emails odeke@ualberta.ca,odeke.ex@gmail.com -message "This is the substring file I told you about" -role writer -type group mnt/substringfinder.c projects/kmp.c
```

For example to share a file with users of a mailing list and a custom message

```
$ drive share -emails drive-mailing-list@gmail.com -message "Here is the drive code" -role group mnt/drive
```

+ Also supports sharing by fileId

```
$ drive share --emails developers@developers.devs --message "Developers, developers developers" --id 0fM9rt0Yc9RTPeHRfRHRRU0dIY97 0fM9rt0Yc9kJRPSTFNk9kSTVvb0U
```

### Unsharing

The `unshare` command revokes access of a specific accountType to a set of files.

```
$ drive unshare -type group mnt/drive
```

+ Also supports unsharing by fileId

```
$ drive unshare --type group --id 0fM9rt0Yc9RTPeHRfRHRRU0dIY97 0fM9rt0Yc9kJRPSTFNk9kSTVvb0U
```

### Touching

Files that exist remotely can be touched i.e their modification time updated to that on the remote server using the `touch` command:

```
$ drive touch Photos/img001.png logs/log9907.txt
```

For example to touch all files that begin with digits 0  to 9:

```
$ drive touch -matches $(seq 0 9)
```

+ Also supports touching of files by fileId

```
$ drive touch --id 0fM9rt0Yc9RTPeHRfRHRRU0dIY97 0fM9rt0Yc9kJRPSTFNk9kSTVvb0U
```

### Trashing and Untrashing

Files can be trashed using the `trash` command:

```
$ drive trash Demo
```

To trash files that contain a prefix match e.g all files that begin with Untitled, or Make

Note: This option uses the current working directory as the parent that the paths belong to.

```
$ drive trash -matches Untitled Make
```

Files that have been trashed can be restored using the `untrash` command:

```
$ drive untrash Demo
```

To untrash files that match a certain prefix pattern

```
$ drive untrash -matches pQueue photos Untitled
```

+ Also supports trashing/untrashing by fileId

```
$ drive trash --id 0fM9rt0Yc9RTPeHRfRHRRU0dIY97 0fM9rt0Yc9kJRPSTFNk9kSTVvb0U
```

```
$ drive untrash --id 0fM9rt0Yc9RTPeHRfRHRRU0dIY97 0fM9rt0Yc9kJRPSTFNk9kSTVvb0U
```


### Emptying the Trash

Emptying the trash will permanently delete all trashed files. They will be unrecoverable using `untrash` after running this command.

```
$ drive emptytrash
```

### Deleting

Deleting items will PERMANENTLY remove the items from your drive. This operation is irreversible.

```
$ drive delete flux.mp4
```

```
$ drive delete --matches onyx swp
```

+ Also supports deletion by fileIds

```
$ drive delete --id 0fM9rt0Yc9RTPeHRfRHRRU0dIY97 0fM9rt0Yc9kJRPSTFNk9kSTVvb0U
```


### Listing Files

The `list` command shows a paginated list of paths on the cloud.

Run it without arguments to list all files in the current directory:

```
$ drive list
```

Pass in a directory path to list files in that directory:

```
$ drive list photos
```

To list matches

```
$ drive list --matches mp4 go
```

The `-trashed` option can be specified to show trashed files in the listing:

```
$ drive list -trashed photos
```

To get detailed information about the listings e.g owner information and the version number of all listed files:

```
$ drive list -owners -l -version
```

+ Also supports listing by fileIds

```
$ drive list -depth 3 --id 0fM9rt0Yc9RTPeHRfRHRRU0dIY97 0fM9rt0Yc9kJRPSTFNk9kSTVvb0U
```

+ Listing allows for sorting by fields e.g `name`, `version`, `size, `modtime`, lastModifiedByMeTime `lvt`, `md5`. To do this in reverse order, suffix `_r` or `-` to the selected key

e.g to first sort by modTime, then largest-to-smallest and finally most number of saves:

```
$ drive list --sort modtime,size_r,version_r Photos
```

* For advanced listing

```
$ drive list --skip-mime mp4,doc,txt
```

```
$ drive list --match-mime xls,docx
```

```
$ drive list --exact-title url_test,Photos
```

### Stating Files

The `stat` commands show detailed file information for example people with whom it is shared, their roles and accountTypes, and
fileId etc. It is useful to help determine whom and what you want to be set when performing share/unshare

```
$ drive stat mnt
```

By default `stat` won't recursively stat a directory, to enable recursive stating:

```
$ drive stat -r mnt
```

+ Also supports stat-ing by fileIds

```
$ drive stat -r --id 0fM9rt0Yc9RTPeHRfRHRRU0dIY97 0fM9rt0Yc9kJRPSTFNk9kSTVvb0U
```

OR

```
$ drive stat -depth 4 --id 0fM9rt0Yc9RTPeHRfRHRRU0dIY97 0fM9rt0Yc9kJRPSTFNk9kSTVvb0U
```

### Retrieving md5 Checksums

The `md5sum` command quickly retrieves the md5 checksums of the files on your drive. The result can be fed into the `md5sum -c` shell command to validate the integrity of the files on Drive versus the local copies.

Check that files on Drive are present and match local files:

```
~/MyDrive/folder$ drive md5sum | md5sum -c
```

Do a two-way diff (will also locate files missing on either side)

```
~/MyDrive/folder$ diff <(drive md5sum) <(md5sum *)
```

Same as above, but include subfolders 

```
~/MyDrive/folder$ diff <(drive md5sum -r) <(find * -type f | sort | xargs md5sum)
```

Compare across two different Drive accounts, including subfolders

```
~$ diff <(drive md5sum -r MyDrive/folder) <(drive md5sum -r OtherDrive/otherfolder)
```

_Note: Running the `drive md5sum` command retrieves pre-computed md5 sums from Drive; its speed is proportional to the number of files on Drive. Running the shell 'md5sum' command on local files requires reading through the files; its speed is proportional to the size of the files._


### New File

drive allows you to create an empty file or folder remotely
Sample usage:

```
$ drive new --folder flux
```

```
$ drive new --mime-key doc bofx
```

```
$ drive new --mime-key folder content
```

```
$ drive new flux.txt oxen.pdf``` # Allow auto type resolution from the extension


### Quota

The `quota` command prints information about your drive, such as the account type, bytes used/free, and the total amount of storage available.

```
$ drive quota
```

### Features

The `features` command provides information about the features present on the
drive being queried and the request limit in queries per second

```
$ drive features
```

### About

The `about` command provides information about the program as well as that about
your Google Drive. Think of it as a hybrid between the `features` and `quota` commands.

```
$ drive about
```

OR for detailed information

```
$ drive about -features -quota
```

### Help

Run the `help` command without any arguments to see information about the commands that are available:

```
$ drive help
```

Pass in the name of a command to get information about that specific command and the options that can be passed to it.

```
$ drive help push
```

To get help for all the commands

```
$ drive help all
```

### Copying

drive allows you to copy content remotely without having to explicitly download and then reupload.

```
$ drive copy -r blobStore.py mnt flagging
```

```
$ drive copy blobStore.py blobStoreDuplicated.py
```

+ Also supports copying by fileIds

```
$ drive copy -r --id 0fM9rt0Yc9RTPeHRfRHRRU0dIY97 0fM9rt0Yc9kJRPSTFNk9kSTVvb0U ../content
```


### Rename

drive allows you to rename a file/folder remotely. To do so:

```
$ drive rename url_test url_test_results
```

```
$ drive rename openSrc/2015 2015-Contributions
```

+ Also supports renaming by fileId

```
$ drive rename 0fM9rt0Yc9RTPeHRfRHRRU0dIY97 fluxing
```


### Move

drive allows you to move content remotely between folders. To do so:

```
$ drive move photos/2015 angles library archives/storage
```

+ Also supports moving by fileId

```
$ drive rename 0fM9rt0Yc9RTPeHRfRHRRU0dIY97 0fM9rt0Yc9kJRPSTFNk9kSTVvb0U ../../new_location
```


### DriveIgnore

drive allows you to specify a '.driveignore' file similar to your .gitignore, in the root
directory of the mounted drive. Blank lines and those prefixed by '#' are considered as comments and skipped.

For example:

`
$ cat << $ >> .driveignore > # My drive ignore file > \.gd$ > \.so$ > \.swp$ > $
`

Note: Pattern matching and suffixes are done by regular expression matching so make sure to use a valid regular expression suffix.

### DesktopEntry

As previously mentioned, Google Docs, Drawings, Presentations, Sheets etc and all files affiliated
with docs.google.com cannot be downloaded raw but only exported. Due to popular demand, Linux users
desire the ability to have \*.desktop files that enable the file to be opened appropriately by an external opener. Thus by default on Linux, drive will create \*.desktop files for files that fall into this category.

### Command Aliases

`drive` supports a few aliases to make usage familiar to the utilities in your shell e.g:
+ cp : copy
+ ls : list 
+ mv : move


### Index Prune


If you would like to fetch missing index files for files that would otherwise not need any modifications, run:

```
$ drive index path1 path2 path3/path3.1``` # To fetch any missing indices in those paths


```
$ drive index --id 0CLu4lbUI9RTRM80k8EMoe5JQY2z
```

You can also fetch specific files by prefix matches

```
$ drive index --matches mp3 jpg
```

* prune

In case you might have deleted files remotely but never using drive, and feel like you have stale indices,
running `drive index --prune` will search your entire indices dir for index files that do not exist remotely and remove those ones

```
$ drive index --prune
```

* prune-and-index
To combine both operations (prune and then fetch) for indices:

```
$ drive index --all-ops
```


### Revoking Account Access

To revoke OAuth Access of drive to your account, when logged in with your Google account, go to https://security.google.com/settings/security/permissions and revoke the desired permissions

### Uninstalling

To remove `drive` from your computer, you'll need to take out:

+ $GOPATH/bin/drive

+ $GOPATH/src/github.com/odeke-em/drive

+ $GOPATH/pkg/github.com/odeke-em/drive

+ $GOPATH/pkg/github.com/odeke-em/drive.a

* Also do not forget to revoke drive's access in case you need to uninstall it.

### Applying patches 
To  apply patches of code e.g in the midst of bug fixes, you'll just need a little bit of git fiddling.

For example to patch your code with that on remote branch patch-1, you'll need to go into the source
code directory, fetch all content from the git remote, checkout the patch branch then run the go installation: something like this.

```
$ cd $GOPATH/src/github.com/odeke-em/drive
```

```
$ git fetch --all
```

```
$ git checkout patch-1
```

```
$ git pull origin patch-1
```

```
$ go get github.com/odeke-em/drive/cmd/drive
```


  </div>
