#!/bin/bash
# For configuring the github CLI app to make authenticated requests over ssh connection.
# Run the following to setup: BROWSER=$PWD/browser.sh;export BROWSER;gh api repos/neverfelly/Meow/releases/latest > /dev/null
# Reason this is necessary: Github CLI either forks the browser or otherwise hides output. You cannot use w3m, elinks, etc for this.
echo $@ > /tmp/browser.txt
