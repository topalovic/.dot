Nikola's dotfiles
=================

## To install

From your home directory, run the following:

```sh
git clone https://github.com/topalovic/.dot
.dot/setup
```

Bam. Done.


## To customize

The setup script will symlink the appropriate files in `.dot` to your home
directory. All further hacking should take place within `~/.dot/files`.

To configure git, create `~/.private/gitconfig` containing your private info:

```
[user]
  name  = Nikola Topalović
  email = nikola@example.org

[github]
  user = topalovic
  token =  <github-token>
```


## To uninstall

Just run the unlink script:

```sh
.dot/unlink
```

This will remove all recognized dotfile links from your home folder.
