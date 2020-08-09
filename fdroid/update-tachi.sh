# get updates

for parm in $*; do
  test "$parm" == nopush && nopush=y
  test "$parm" == nodl && nodl=y
  test "$parm" == update && update=y
  if test "$parm" == help; then
    echo "nopush: don't push to repo"
    echo "nodl: don't download app updates, only extensions"
    echo "update: run fdroid update --clean"
    exit
  fi
done

cd $HOME/tachiyomi-extensions
if
  git fetch && test -z "$(git diff origin/repo)"
then
  echo "Already up to date!"
  echo "Consider ./download_apps.sh"
  exit
fi

git pull

# get a list of new extensions
apkfiles="$(git diff --summary --color=always HEAD@{1} HEAD@{0} apk/*.apk|grep create|sed -E 's/^.*?apk.(.*?\.apk)$/\1/g')"

cd $HOME/fdroidserver/fdroid
# get the current git revision
oldrev=$(git rev-parse HEAD)

for file in $apkfiles
do
	cp $HOME/tachiyomi-extensions/apk/$file repo/$file --preserve=all
done
cd $HOME/fdroidserver/fdroid

git add archive repo metadata tmp
git commit -m "$apkfiles"

# now run download_apps.sh unless told not to
#test -n "$nodl" && ./download_apps.sh nopush

# update if requested
#if test -n "$update"; then
#  ./fdroid.sh update --create-metadata --pretty --use-date-from-apk --clean
#  git add archive repo metadata tmp
#  git commit -m "clean update"
#fi

# dont push if run in a script.
#test -n "$nopush" && git push

# for my personal use
#if type xmllint &> /dev/null; then
#  xmllint --format repo/index.xml > repo.xml
#  xmllint --format archive/index.xml > archive.xml
#fi

# output a diff. I only care about apk files...
#                - except not anymore, since I'm not usually running fdroid
#git diff $oldrev --compact-summary --color=always --relative=fdroid # *.apk #|less -XFR

# give a few seconds to avoid pushing. Also keep copies of upstream up to date.
#read -n1 -e -t 30 -p 'Push? <Y/N> ' gitpush
#case $gitpush in
#  [Nn] ) echo "Aborting...Clean it up yourself" $gitrev;;
#  * ) git push
#      git fetch inorichi master:upstream/master > /dev/null
#      git fetch inorichi repo:upstream/repo > /dev/null
#      git push origin master upstream/repo upstream/master;;
#esac
#echo "Old hash: $oldrev"
#echo "Current hash: $(git rev-parse HEAD)"

