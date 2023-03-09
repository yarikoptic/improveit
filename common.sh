branch=$(git rev-parse --abbrev-ref HEAD)
ghuser=$(git config github.user)
ghremote=gh-${ghuser:-mine}

if [ -z "${GITHUB_TOKEN:-}" ]; then
    # if not available -- load from config possibly
    GITHUB_TOKEN=$(git config hub.oauthtoken)
fi

if ! git remote | grep "$ghremote"; then
   if ! GH_TOKEN="$GITHUB_TOKEN" gh repo fork --remote --remote-name "$ghremote"; then
    echo "errored out, sleeping, trying to fetch"
    sleep 2
    git fetch "$ghremote"
   fi
fi
mkdir -p .github/workflows

