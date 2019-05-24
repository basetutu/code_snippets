=============================================================================================

# How to setup a git server
https://git-scm.com/book/en/v2/Git-on-the-Server-The-Protocols

=============================================================================================

GIT HELP

https://help.github.com/

# Best Cheatsheet
https://gist.github.com/hofmannsven/6814451

=============================================================================================

# git command history
git reflog

https://stackoverflow.com/questions/134882/undoing-a-git-rebase

# git undo command
# use 'git reflog' to find the command to reset to, then: (5 is the index of the command in reflog stack)
git reset --hard HEAD@{5}

=============================================================================================

NOTE:
Use always a new branch for each work.
Start from the development branch and create from it after having rebased it.
NOTE:
Pulled commits wont be pushed with other local commits upon 'git push'

=============================================================================================

// When code-review is received, checkout to that branch and make the changes.
// When done, use:
git commit --amend
// This will allow you to keep the last change-id that Garrit recognizes but allow you to change
// the commit text.

// When this is done, use:
git push ssh://saeed.ghasemi@sc-srv-p-bygg01:29418/hertz-polybus HEAD:refs/for/develop
// This will push the changes to the remote develop-branch.

=============================================================================================

// Branch visualization:
git log --graph --decorate --oneline --full-history
// or 
gitk

=============================================================================================

STASHING:

git stash
git stash pop (removes the stash when applied)
git stash apply
git stash apply stash@{0}
git stash list
git stash show

// Delete stash
git stash drop stash@{0}

// Unapply stash
git stash show -p stash@{0} | git apply -R

// Create a new branch based on a stash (deletes the stash if successful)
git stash branch new_branch_name


--> Instead of stashing you can do temporary commits with below command

# Create a temporary commit, then later ...
# Undo a commit, but keep the changes and put them into working directory. (both command are equivalent)
git reset HEAD^
git reset HEAD~1

# RESET DEMYSTIFIED
https://git-scm.com/2011/07/11/reset.html
# How to undo (almost) anything with Git
https://github.com/blog/2019-how-to-undo-almost-anything-with-git

=============================================================================================

// Detach from all branches
git checkout --detach

// Get the project path (project ID)
git rev-parse --show-toplevel

=============================================================================================

# Creating new commands (alias) for git
example:
git config --global alias.stash-unapply '!git stash show -p | git apply -R'
// Created stash-unapply that performs 'stash show -p | git apply -R'

=============================================================================================

#I-SEE:

# GITHUB ################################

git clone git@github.com:LuxWTeam/ios-application.git

# Local GIT ################################

# Git clone:
git clone ssh://saeed.ghasemi@sc-srv-p-bygg01:29418/isee/nrf52_sdk && scp -p -P 29418 saeed.ghasemi@sc-srv-p-bygg01:hooks/commit-msg nrf52_sdk/.git/hooks/

# Deleting a remote branch (experimental) (for should probably be replaced with heads)
git push origin refs/for/<branch>
# git push to gerrit
git push origin HEAD:refs/for/master
# git push to gerrit without thinning/data reduction (--no-thin) (this solves some issues with pushes resulting in "nothing changed" error)
git push --no-thin sigma HEAD:refs/for/master

=============================================================================================

#BEIJER

# How to init repo with the manifest git repository
repo init -u ssh://tfs.beijerelectronics.com/HmiDev/Git/_git/manifest -b krogoth-x2

=============================================================================================

#ENGELBERT:

# repo init
repo init -u ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/manifest -b bui3xx-develop

# git push draft

git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/apps/connectivity-test HEAD:refs/drafts/bui3xx-develop

git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/build/script HEAD:refs/drafts/bui3xx-develop

git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/device/bui3xx HEAD:refs/drafts/bui3xx-develop

git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/services-api HEAD:refs/drafts/bui3xx-develop

git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/appfw/js-api HEAD:refs/drafts/bui3xx-develop

git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/os/libdbushelper HEAD:refs/drafts/bui3xx-develop


git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/appfw/cefextensions/location-manager HEAD:refs/drafts/bui3xx-develop

git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/appfw/cefextensions/wifi-manager HEAD:refs/drafts/bui3xx-develop

git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/appfw/cefextensions/bluetooth-manager HEAD:refs/drafts/bui3xx-develop


git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/location-manager HEAD:refs/drafts/bui3xx-develop

git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/wifi-manager HEAD:refs/drafts/bui3xx-develop

git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/bluetooth-manager HEAD:refs/drafts/bui3xx-develop


# git push publish
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/services/location-manager HEAD:refs/for/bui3xx-develop

# Push a single commit to garrit develop-branch
git push ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/apps/connectivity-test HEAD:refs/drafts/bui3xx-develop <commit SHA>:refs/drafts/bui3xx-develop

​=============================================================================================

HERTZ

// Set Diffie helmand as handshaking method
export GIT_SSH_COMMAND='ssh -o KexAlgorithms=+diffie-hellman-group1-sha1'

// Push all commits to garrit develop-branch
git push ssh://saeed.ghasemi@sc-srv-p-bygg01:29418/hertz-polybus HEAD:refs/for/develop
git push ssh://saeed.ghasemi@sc-srv-p-bygg01:29418/hertz-polybus HEAD:refs/heads/certification

// Push a single commit to garrit develop-branch
git push ssh://saeed.ghasemi@sc-srv-p-bygg01:29418/hertz-polybus <commit SHA>:refs/for/develop

// get the hook that adds a Change-id to the commits, as used by gerrit:
scp -o KexAlgorithms=+diffie-hellman-group1-sha1 -p -P 29418 saeed.ghasemi@sc-srv-p-bygg01:hooks/commit-msg .git/hooks/

=============================================================================================

WORKING WITH TAGS

#Pushes all tags to current tracking remote branch
git push --tags

#Create a tag
git tag v0.8.1

#Delete a tag
git tag -d v0.9.1

#To see all tags
git tag

# Become a master in git tag
https://blog.daftcode.pl/how-to-become-a-master-of-git-tags-b70fbd9609d9

=============================================================================================

WORKING WITH REMOTES

# Rename a remote from origin to sigma
git remote rename origin sigma

# Adding a new remote to the git (new_remote will be the name of the remote)
git remote add new_remote https://github.com/user/repo.git

=============================================================================================

WORKING WITH COMMITS

// Interactivt commit text modification
git rebase -i

// Ammending changes to the latest commit
git commit --amend

// Remove a commit from the git history
git rebase --onto <commit-id>^ <commit-id>
// Use answer 3 and 4 from this article:
http://stackoverflow.com/questions/37219/how-do-you-remove-a-specific-revision-in-the-git-history

// Changing the author of a commit
git commit --amend --author="Saeed Ghasemi <saeed.ghasemi@sigma.se>"

// Squash commits into one. The commit that all squash-commits need to merge into must be set
// to 'pick' and the others to 'squash'.
git rebase -i HEAD~2


=============================================================================================
FRÅN HENRIK:

Skapa diff och lägga på den
===========================
git diff > sample.diff
patch -p1 < sample.diff


Skapa git .patch-filer av existerande commits
======================
1. Hitta basen, dvs commit, där patchar skall utgå från med git log.    
2. Anropa
   $ git format-patch <SHA>
   ex: $ git format-patch a59eb8bbb3d908e32435351f1554902cbc7e568
  
   Nu skapas ett antal .patch-filer, en för varje commit sedan utvald bas.

Applicera patcharna
===================
1. Hitta .patch-filerna och lägg i rätt folder
2. Kör git am filename.patch för vrje patch som skall läggas på. Börja med '0001'-filen.
   Ex: git am 0001-DRM-FW-extension.patch
3. Kontrollera resultat med git log

# Create a patch-file between two branches in git
====================
git diff master Branch1 > ../patchfile   # Create a patch-file between two branches
git checkout Branch2    # create a new branch and switch to it
git apply ../patchfile  # Apply the patch-file

====================

// Revert a patch
git apply -R <patch>

=============================================================================================

# Patching files with git

# Store one patch on file
git format-patch -1 <SHA>
# or a list of patches from SHA position (HEAD~x can be used as SHA)
git format-patch -5 <SHA>
git format-patch <from> <to>
# or the last patch
git format-patch -1 HEAD

# Applying the patch:
 # show stats
git apply --stat file.patch
 # check for error before applying
git apply --check file.patch
 # apply the patch finally
git am < file.patch

# To apply using 3-way merging which will let you resolve conflicts using git mergetool afterward (or editing manually)

extra:

# Apply a patch from file (.patch) to git history
git am file.patch

=============================================================================================

EXAMPLES OF cherry pick AND format patch

git fetch ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/apps/connectivity-test refs/changes/29/2329/1 && git cherry-pick FETCH_HEAD

git fetch ssh://ghs1lr@rb-gerrit-ebike.de.bosch.com:29418/platform/apps/connectivity-test refs/changes/29/2329/1 && git format-patch -1 --stdout FETCH_HEAD

=============================================================================================

# How to reset/revert a file

# Undo modifications (restore files from latest commited version):
git checkout -- <file-path as in git-status>

# Cheking out a file to an earlier version as in a commit (revert)
# Here, the commit-id is the earlier commit with the needed version of the file.
# The path indicates the file in question.
git checkout <SHA> <file-path as in git-status>

# Experimental
git checkout HEAD <file-path as in git-status>

# The file is now green (staged). It must be staged again to work.
# Aftr this, do an amend. The downgraded file is now saved in the last commit.

=============================================================================================

SETTINGS

// Change the remote branch that is being tracked (link to remote branch)
git branch branch_name1 --set-upstream-to origin/branch_name2

// To set the git-editor (Set core.editor in your Git config: )
git config --global core.editor "nano"
// or set the GIT_EDITOR environment variable:
export GIT_EDITOR=nano

=============================================================================================

// Untrack/unstage a file
git rm --cached <filePath>

// initialize a new git repository in current folder which starts the file versioning proccess
git init

=============================================================================================

// Show the changed done by a commit (-1 indicate that the changes should include the latest commit)
git show -1

==============================================================================================

git diff e8ac9509ead6988c2f89f1784e3307272f5e3c9f | grep RSSI | more

git log --name-only

# To see the branchings in graph form
git log --decorate --graph
git log --graph --decorate --oneline --full-history

# To see the 'Last Commit Date' as well as the author date
git log --format=fuller

# See the changes of the most recent commit (only commited changes)
git difftool HEAD~0 ^HEAD~1

# How to define meld as difftool default
git config --global diff.tool meld

==============================================================================================

# Print the code changes done between any two commit
git log <commit SHA>..<commit SHA> -p

=============================================================================================

// Show current uncommitted changes
git diff

=============================================================================================

# GIT Submodules

# To add a submodule to git
git submodule add https://github.com/google/googletest.git
# To see the registrated submodules
git submodule
# To initialize the submodules
git submodule init
# To update the submodules
git submodule update
# To see the registrated module in git settings (new file if it is the first submodule)
cat .gitmodules 
# To remove the submodule
git submodule deinit -f googletest/ # remove -f to not to force this

=============================================================================================






=============================================================================================
=============================================================================================
=============================================================================================
REPO
=============================================================================================
=============================================================================================

# Understand the repo manifest xml
https://docs.sel4.systems/RepoCheatsheet.html

=============================================================================================

repo sync
repo status
repo branch
repo diff

repo push

-------------------------------------------------------

// Get the project path (project ID)
repo forall -c 'git rev-parse --show-toplevel'

-------------------------------------------------------

# Invoke 'git status' on all git repositories
repo forall -c "git status"

-------------------------------------------------------

# Create your local branch
$ repo start <new branch name> --all

-------------------------------------------------------

# Push local branches to remote git
git push -u origin newLocalBranch

-------------------------------------------------------

# Sync a single repository
repo sync platform/appfw/cefextensions/location-manager

# The path to the repository can be found in .repo/manifest.xml
-------------------------------------------------------

# Status on a single repository
repo status platform/appfw/cefextensions/location-manager

-------------------------------------------------------

ENGELBERT

repo forall -c 'git rev-parse --show-toplevel'

repo forall -c 'git checkout -b develop m/bui3xx-develop'

repo forall -c 'git status'

repo forall -c 'git checkout x'

repo forall -c 'git commit -m "(connectivity)"'


-------------------------------------------------------

-------------------------------------------------------









=============================================================================================
=============================================================================================
=============================================================================================
SubVersion
=============================================================================================
=============================================================================================
=============================================================================================


