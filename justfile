#!/usr/bin/env -S just --justfile

[private]
default:
    @just --list --unsorted

[group('utils')]
fmt:
    deno fmt

[group('dev')]
start: dist serve

[group('dev')]
dist:
    mkdir -p dist/public_html
    lessc web/styles/main.less dist/public_html/style.css
    deno bundle web/scripts/main.ts -o dist/public_html/main.js
    cp -t dist/public_html web/index.html

[group('dev')]
serve:
    http-server --cors -c-1 -p 4200 dist/public_html
