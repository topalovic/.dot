Nikola's dotfiles
=================

## Setup

Clone the repo to your home folder and run:

```sh
~$ .dot/setup
```

:facepunch: Bam. Done.


## Customization

The setup script will symlink everything that matches
`.dot/files/**/dot.*` to your home directory.

To configure git, set up `~/.private/.gitconfig` with your personal
info:

```
[user]
  name  = Nikola Topalović
  email = nikola@example.org

[github]
  user  = topalovic
  token = <github-token>
```

Check `.dot/bin` and `.dot/etc` for optional goodies.


## Cleanup

To uninstall, just run the unlink script:

```sh
~$ .dot/unlink
```

This will remove all recognized dotfile links from `~`.
