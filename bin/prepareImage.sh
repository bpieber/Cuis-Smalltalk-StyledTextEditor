#!/bin/bash
NAME="$1"
BUILD="$2"
cd $NAME
ditto ../Cuis-StyledTextEditor/ClipboardExtendedPlugin.bundle/ Cog.$BUILD.app/Contents/Resources/ClipboardExtendedPlugin.bundle/
mv Cog.$BUILD.app Cog.$BUILD.ClipboardExtendedPlugin.app
