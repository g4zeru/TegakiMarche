#!/bin/bash

"${PODS_ROOT}/SwiftFormat/CommandLineTool/swiftformat" . --exclude Carthage,Pods --trimwhitespace nonblank-lines --stripunusedargs closure-only --disable strongOutlets,trailingCommas

if which swiftlint >/dev/null; then
swiftlint autocorrect --format
swiftlint
else
echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
