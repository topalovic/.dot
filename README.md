Nikola's dotfiles
=================

## Setup

Clone the repo to your home folder and run:

```sh
$ .dot/setup
```

:facepunch: Bam. Done.


## Customization

To round off git configuration, set up `~/.private/gitconfig` with
your personal info:

```ini
[user]
  name  = Nikola Topalović
  email = nikola@example.org

[github]
  user  = topalovic
  token = <github-token>
```

For secret vars and other local data, provide a `~/.private/env`
script that will be sourced automatically.

Grab the
[pre-patched fonts for powerline](https://github.com/powerline/fonts)
and don't forget to check [bin](bin/) and [etc](etc/) for optional
goodies.


## Cleanup

To uninstall, just run the unlink script:

```sh
$ .dot/unlink
```

This will clean all recognized dotfile links from `~`.
