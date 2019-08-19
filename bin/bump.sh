  git config --global user.name "  Kite Bot"
  git config --global user.email "kite-bot@heliostech.fr"
  git remote add authenticated-origin https://kite-bot:$GITHUB_API_KEY@github.com/${DRONE_REPO}
  git fetch authenticated-origin
  curl -sL https://deb.nodesource.com/setup_10.x | bash -

  scan_git() {
      if git log --oneline -n 1 HEAD | grep -qi 'patch'; then
        variable="patch"
      elif git log --oneline -n 1 HEAD | grep -qi 'minor'; then
        variable="minor"
      elif git log --oneline -n 1 HEAD | grep -qi 'major'; then
        variable="major"
      else comit_hash=`git rev-parse HEAD | cut -c 1-8`
     fi
  }
  scan_git()

  if -n variable; then
   case "$1" in
      -r|--ruby)
        gem install bump
        CMD="bump $variable"
        ;;
      -j|--js)
        apt-get update && apt-get install -y nodejs
        CMD="yarn version --$variable"
        ;;
      -g|--go)
        FLAG=1
        go get github.com/Clever/gitsem
        CMD="gitsem $variable"
        ;;
    esac
    eval $CMD
    export V=$(cat VERSION)
  fi

  bin/gendocs
  git add .
  if -n variable; then
    git tag $(cat VERSION)
  elif FLAG != 1; then
    git tag $(comit_hash)
  fi
  git push authenticated-origin ${DRONE_BRANCH}
  git push --tags authenticated-origin
  git describe --tags $(git rev-list --tags --max-count=1) > .tags

exit
