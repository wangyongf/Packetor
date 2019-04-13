#!/usr/bin/env bash
# note: you should execute this shell script under root project directory.
protoc --dart_out=lib/model android/app/src/main/proto/nat_session.proto
protoc --dart_out=lib/model android/app/src/main/proto/nat_session_request.proto
mv lib/model/android/app/src/main/proto/*.dart lib/model/
rm -rf lib/model/android
git add .
echo "proto generated success. ^_^"
