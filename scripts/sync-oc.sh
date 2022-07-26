#!/usr/bin/env bash

set -e
set -x

ROOT_PATH=$1

cp -RP $ROOT_PATH/macos/Classes/TextureRenderer.h $ROOT_PATH/ios/Classes/TextureRenderer.h
cp -RP $ROOT_PATH/macos/Classes/TextureRenderer.mm $ROOT_PATH/ios/Classes/TextureRenderer.mm

cp -RP $ROOT_PATH/macos/Classes/VideoViewController.h $ROOT_PATH/ios/Classes/VideoViewController.h
cp -RP $ROOT_PATH/macos/Classes/VideoViewController.mm $ROOT_PATH/ios/Classes/VideoViewController.mm

