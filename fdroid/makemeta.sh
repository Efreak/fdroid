#!/usr/bin/env bash
function getinfo(){
  echo "Categories:"
  echo "  - Tachiyomi Extensions"
  echo "WebSite: https://github.com/inorichi/tachiyomi-extensions"
  echo "SourceCode: https://github.com/inorichi/tachiyomi-extensions"
  echo "IssueTracker: https://github.com/inorichi/tachiyomi-extensions/issues"
  name=$(aapt dump badging "$1"|fgrep 'application-label:'|sed -E "s/^.*?Tachiyomi\: (.*?)'$/\1/")
  lang=$(echo "$1"|sed -E 's/^.*?tachiyomi-(...?)\..+$/\1/g'|tr '[:lower:]' '[:upper:]')
  echo "Name: 'Tachiyomi: $name ($lang)'"
  echo "Summary: Tachiyomi $name Extension"
}
function getout(){
  echo $'New metadata:\n'
  for pkg in $*; do
    package=$(aapt dump badging "$pkg"|fgrep 'package: '|head -1|sed -E "s/^.*?name='([^']+)'.+$/\1/")
    getinfo "$pkg" > "metadata/$package.yml"
    ./fdroid.sh rewritemeta "$package"  > /dev/stderr
    git add "metadata/$package.yml"
    echo $pkg
  done | fgrep apk|sed 's/repo\///g'
}
out=$(getout $*)
git commit -m "$out"
git log @...@~1
