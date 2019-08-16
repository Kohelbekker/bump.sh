#!/usr/bin/bash

  if  [[ $# -lt 1 ]]; then
    echo "FUCK" #exit 0
  fi

  case "$1" in
    -r|--ruby)
      CMD="bump $variable"
      ;;
    -j|--js)
      CMD="yarn version --$variable"
      ;;
    -g|--go)
        CMD=""
      ;;
  esac
exit
## gem install bump
## git config --global user.name "  Kite Bot"
## git config --global user.email "kite-bot@heliostech.fr"
## git remote add authenticated-origin https://kite-bot:$GITHUB_API_KEY@github.com/${DRONE_REPO}
## git fetch authenticated-origin
## curl -sL https://deb.nodesource.com/setup_10.x | bash -
## apt-get update && apt-get install -y nodejs
## export V=$(cat VERSION)
## bin/gendocs
## git add .
## bump patch --commit-message 'Bump [ci skip]'
## git tag $(cat VERSION)
## git push authenticated-origin ${DRONE_BRANCH}
## git push --tags authenticated-origin
## git describe --tags $(git rev-list --tags --max-count=1) > .tags
