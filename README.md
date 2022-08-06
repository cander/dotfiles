# WTF?

These are my dot/config files.  I put them under Mercurial years ago, but
never used hg for a distribution scheme because at the time I was working
at a Subversion shop.  In part because of that and part because of
laziness, these files have been rotting.  No longer.  I'll start hacking
on them, cleaning them, adding to them, and fixing various bugs.  

For the record, the shell and vi configurations go back to the 80s.  Some
of those things started with my csh environment.  Then things were merged
from a setup I used for a bootleg version of ksh (before there was any
open-source version).  Then, I migrated to bash.  There's been some
fiddling, but not much real work.

## Vim Module Voodoo

In its current form, I'm using git submodules for the vim plugins. (Should
move to the built-in plug-in manager now that most/all of my machines are on
vim 8. These are basic notes for me for future reference (after NerdTree
broke after updating MacOS)

To update a submodule:
```
git submodule update --remote vim/bundle/scrooloose-nerdtree
git commit       # trivial one-file change
git push origin master
```

To pull those changes down on another machine:
```
git pull origin master
git submodule update
```

# TODO
* Write an installer
* Massive re-org and clean-up of the bash initialization.
* Fix new-ish(?) bug(s) in the directory stack
* Write a real README

# Partial Credits
Here's a list of some of the sources I may have cribbed from / been
inspired by:
* https://github.com/skwp/dotfiles - installer Rakefile
