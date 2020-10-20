#!/usr/bin/env python3

import os

sdk_path = "$ANDROID_HOME"

repo_url = "https://tachi.efreakbnc.net/fdroid/repo"
repo_name = "Unofficial Tachiyomi Extensions F-Droid Repo"
repo_icon = "tachi-icon.png"
repo_description = """
This is a repository of source extensions to be used with Tachiyomi.
Applications in this repository are official binaries built and
signed by the developers of Tachiyomi and copied to this directory.
"""

archive_older = 1
archive_url = "https://tachi.efreakbnc.net/fdroid/archive"
archive_name = "Unofficial Tachiyomi Extensions F-Droid Archive"
archive_icon = "tachi-icon.png"
archive_description = """
The repository of older versions of source extensions to be used with Tachiyomi.
Applications in this repository are official binaries built and
signed by the developers of Tachiyomi and copied to this directory.
"""

make_current_version_link = False

# current_version_name_source = 'packageName'

# The ID of a GPG key for making detached signatures for apks. Optional.
# gpgkey = '1DBA2E89'

repo_keyalias = "Lenovo.localdomain"
keystore = os.environ["KEYSTORE"]
keystorepass = os.environ["KEYSTOREPASS"]
keypass = os.environ["KEYPASS"]
keydname = "CN=Lenovo.localdomain, OU=F-Droid"

# The full URL to a git remote repository. You can include
# multiple servers to mirror to by wrapping the whole thing in {} or [], and
# including the servergitmirrors strings in a comma-separated list.
# Servers listed here will also be automatically inserted in the mirrors list.
#
servergitmirrors = {
    'https://github.com/Efreak/tachiyomi-extensions'
}

# Any mirrors of this repo, for example all of the servers declared in
# serverwebroot and all the servers declared in servergitmirrors,
# will automatically be used by the client.  If one
# mirror is not working, then the client will try another.  If the
# client has Tor enabled, then the client will prefer mirrors with
# .onion addresses. This base URL will be used for both the main repo
# and the archive, if it is enabled.  So these URLs should end in the
# 'fdroid' base of the F-Droid part of the web server like serverwebroot.
#
mirrors = (
#    'https://tachiext.netlify.com/fdroid',
    'https://tachi.cloud.efreakbnc.net/fdroid',
# this is occasionally used on my local network. If it annoys you, disable it.
# you can do this by opening the repo settings in fdroid.
#    'http://192.168.0.2:8000/fdroid',
# the rawgit alternatives. too lazy to see what sticks around, so toss em all in here...
#    'https://cdn.statically.io/gh/Efreak/tachiyomi-extensions/master/fdroid',
#    'https://cdn.jsdelivr.net/gh/Efreak/tachiyomi-extensions@master/fdroid',
#    'https://rawgit2.com/efreak/tachiyomi-extensions/master/fdroid',
#    'https://gitcdn.xyz/Efreak/tachiyomi-extensions/master/fdroid'
#    'https://gitcdn.link/Efreak/tachiyomi-extensions/master/fdroid'
#    'https://raw.githack.com/Efreak/tachiyomi-extensions/master/fdroid',
#    'https://ghcdn.rawgit.org/Efreak/tachiyomi-extensions/master/fdroid',
#    'https://combinatronics.com/Efreak/tachiyomi-extensions/master/fdroid'
)
uninstall_list = (
    'eu.kanade.tachiyomi.extension.en.mangakakalot',
    'eu.kanade.tachiyomi.extension.en.manganelo',
    'eu.kanade.tachiyomi.extension.en.toonily',
    'eu.kanade.tachiyomi.extension.en.getmanhwa',
    'eu.kanade.tachiyomi.extension.es.doujinhentai',
    'eu.kanade.tachiyomi.extension.id.komikgo',
    'eu.kanade.tachiyomi.extension.en.lhtranslation',
    'eu.kanade.tachiyomi.extension.ja.rawlh',
    'eu.kanade.tachiyomi.extension.ja.rawqq',
    'eu.kanade.tachiyomi.extension.en.manhwa18',
    'eu.kanade.tachiyomi.extension.vi.truyentranhlh',
    'eu.kanade.tachiyomi.extension.es.heavenmanga',
    'eu.kanade.tachiyomi.extension.en.heavenmanga',
    'eu.kanade.tachiyomi.extension.en.naniscans',
    'eu.kanade.tachiyomi.extension.pt.mangalivre',
    'eu.kanade.tachiyomi.extension.ko.manhwahand',
    'eu.kanade.tachiyomi.extension.all.wpmanga',
    'eu.kanade.tachiyomi.extension.en.mangazuki',
    'eu.kanade.tachiyomi.extension.en.shoujosense',
    'eu.kanade.tachiyomi.extension.en.mangafox',
    'eu.kanade.tachiyomi.extension.en.psychoplay',
    'eu.kanade.tachiyomi.extension.en.mangacow',
    'eu.kanade.tachiyomi.extension.en.mangago',
    'eu.kanade.tachiyomi.extension.en.mangaplus',
    'eu.kanade.tachiyomi.extension.en.manhwahentai',
    'eu.kanade.tachiyomi.extension.en.mangarock',
)
