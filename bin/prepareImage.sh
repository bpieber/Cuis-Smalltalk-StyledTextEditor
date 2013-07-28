#!/bin/bash
NAME="$1"
cd $NAME
ditto ../Cuis-Smalltalk-StyledTextEditor/ClipboardExtendedPlugin.bundle/ Cog.app/Contents/Resources/ClipboardExtendedPlugin.bundle/
mv Cog.app Cog.ClipboardExtendedPlugin.app
