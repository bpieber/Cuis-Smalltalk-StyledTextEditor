#!/bin/bash
NAME="$1"
BUILD="$2"
cd $NAME
ditto ../Cuis-StyledTextEditor/ClipboardExtendedPlugin.bundle/ Cog.$BUILD.app/Contents/Resources/ClipboardExtendedPlugin.bundle/
tar -xf ../Cuis-StyledTextEditor/scowl-7.1.tar.gz
