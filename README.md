# codespellit

A trivial helper to setup and run codespell'ing  for a GitHub project.

It relies on two config vars being set in your global `~/.gitconfig` (pardon
for historical inconsistency), optionally:

- `github.user` -- username on github to use to add remote named after it
  with prefix gh-, i.e. for me it is `gh-yarikoptic`.

- `hub.oauthtoken` -- token to use if no `GITHUB_TOKEN` variable is set.
  I would recommend to not store in the default `~/.gitconfig` which you 
  might eventually share with someone.  One solution is to have dedicated
  config like `~/.gitconfig-private` with restricted permissions and outside 
  of any VCS, and then add to your `~/.gitconfig`

      [include]
      path = ~/.gitconfig-private


