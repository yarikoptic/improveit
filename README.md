# improveit

Trivial helpers to setup and run codespell or shellcheck'ing  for a GitHub project.


- [`codespellit`](./codespellit) -- add [codespell](https://github.com/codespell-project/codespell/) workflow, and config
- [`shellcheckit`](./shellcheckit) -- add [shellcheck](https://www.shellcheck.net/) workflow
- [`prit`](./prit) -- submit PR in your fork

All are just script in the top directory ATM, place them into your PATH for convenience
or just invoke with full path, e.g.

    cd /root/of/project/git
    shellcheckit  # to generate remote clone, add remote, commit workflow
    prit  # send a PR

**Disclaimer: they are ad-hoc and ugly, but work!  Use at your own risk and/or pleasure.**

Improvement or proper reimplementation PRs are welcome.

## Dependencies

- Uses GitHub [`gh` client](https://cli.github.com/) (`sudo apt-get
install gh` on Debian-based systems).

- Relies on two config vars being set in your global `~/.gitconfig` (pardon
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
