#!/bin/bash

trap '\033[31;1mForced to exit\033[m' ERR

xcodegen generate
pod install
mint install realm/swiftlint
mint install nicklockwood/SwiftFormat
cp ./IDETemplateMacros.plist ./Seasoning-E-Commerce.xcworkspace/xcshareddata/IDETemplateMacros.plist
echo "-------------------------------------"
echo -e "| \033[32;1mAll Done ❤️  \033[m Let's start Coding!! |"
echo "-------------------------------------"
