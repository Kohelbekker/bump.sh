  install bump
  git config --global user.name "  Kite Bot"
  git config --global user.email "kite-bot@heliostech.fr"
  git remote add authenticated-origin https://kite-bot:$GITHUB_API_KEY@github.com/${DRONE_REPO}
  git fetch authenticated-origin
  curl -sL https://deb.nodesource.com/setup_10.x | bash -
  apt-get update && apt-get install -y nodejs

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

  go get github.com/Clever/gitsem
  
  if -n variable; then
    case "$1" in
      -r|--ruby)
        CMD="bump $variable"
        ;;
      -j|--js)
        CMD="yarn version --$variable"
        ;;
      -g|--go)
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
  else
    git tag $(comit_hash)
  git push authenticated-origin ${DRONE_BRANCH}
  git push --tags authenticated-origin
  git describe --tags $(git rev-list --tags --max-count=1) > .tags

exit
