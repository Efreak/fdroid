#!/usr/bin/env bash

if ! (type curl && type jq && type gh) &>/dev/null; then
  echo -e 'Please install curl, jq and gh (github.com/cli/cli).'
  exit 1
fi

cd $HOME/fdroidserver/fdroid/repo

predl="$(ls)"

function get_latest_gh_release(){
    echo "Checking releases for $1"
    gh api "repos/$1/releases"|jq '.[0].assets[].browser_download_url'| fgrep -i .apk |cut -d\" -f2 | while read url; do
        echo "Downloading $url"
        rm -f incoming.apk # clean up because I do stupid things
        curl -sL "$url" --output incoming.apk
        mv -n incoming.apk $(aapt dump badging incoming.apk|head -1|sed -e "s/'/"'"/g' -Ee 's/.*?name="([^"]+)".*?versionCode="([^"]+)".*?versionName="([^"]+)".+/\1_v\3_\2.apk/g')
        rm -f incoming.apk # clean up if last command failed (if the file wasn't actually an apk file for some reason)
        echo
    done
}

get_latest_gh_release 'jobobby04/TachiyomiSYPreview'
get_latest_gh_release 'az4521/TachiyomiAZ'
get_latest_gh_release 'jays2kings/tachiyomi'
get_latest_gh_release 'inorichi/tachiyomi'
get_latest_gh_release 'CarlosEsco/Neko'

echo 'Downloading tachi debug from https://tachiyomi.kanade.eu/latest'
curl -s -L 'https://tachiyomi.kanade.eu/latest' --output debug.apk
mv -n debug.apk $(aapt dump badging debug.apk|head -1|sed -e "s/'/"'"/g' -Ee 's/.*?name="([^"]+)".*?versionCode="([^"]+)".*?versionName="([^"]+)".+/\1_v\3_\2.apk/g')

echo 'Downloading az4521/TachiyomiAZ debug version from https://crafty.moe/tachiyomiAZ.apk'
curl -s -L 'https://crafty.moe/tachiyomiAZ.apk' --output azdebug.apk
mv -n azdebug.apk $(aapt dump badging azdebug.apk|head -1|sed -e "s/'/"'"/g' -Ee 's/.*?name="([^"]+)".*?versionCode="([^"]+)".*?versionName="([^"]+)".+/\1_v\3_\2.apk/g')

rm -f {,az}debug.apk

#TODO: git stash before dl, and git diff here instead
#no, that's a stupid idea. just dont leave stuff behind
newstuff=$(diff <(echo "$predl") <(ls) | cut -d'>' -f2- -s)

# if there's no new files, then exit
if test -z "$newstuff"
then exit
fi

# alert me
echo 'New files:'
echo "$newstuff"

# now move older versions of tachiyomi.debug to archive, if it's been updated
if
  echo "$newstuff"|fgrep eu.kanade.tachiyomi.debug > /dev/null
then
  # if I've messed with it manually, make sure a copy remains
  while test $(ls eu.kanade.tachiyomi.debug*|wc -l) -gt 1
  do mv -vt ../archive $(ls eu.kanade.tachiyomi.debug* -v|head -1)
  done
fi

# and update git
cd $HOME/fdroidserver/fdroid
git add repo archive
git commit -m "$(echo $'Update apps: \n\n'"$newstuff")"

# dont push if run in a script.
#test "$1" != nopush && git push

# now update fdroid
#./fdroid.sh update --create-metadata --pretty --use-date-from-apk
#git add repo archive tmp
#git commit --amend --no-edit

# (I should probably consider using --no-sign instead)
