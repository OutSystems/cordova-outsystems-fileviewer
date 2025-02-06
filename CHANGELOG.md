# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Chores
- (ios) Replace `cordova-plugin-add-swift-support` plugin with the `SwiftVersion` preference (https://outsystemsrd.atlassian.net/browse/RMET-4037).

## [Version 1.0.7]

### 07-11-2024
- Fix: Opening files on Android apps targetting Android 15.

## [Version 1.0.6]
### Fixes
- Moved the plugin's class extensions to the class itself. (https://outsystemsrd.atlassian.net/browse/RMET-1769)

## [Version 1.0.5]
### Fixes
- Removed hook that adds swift support and added the plugin as dependecy. (https://outsystemsrd.atlassian.net/browse/RMET-1680)

## [Version 1.0.4]

## 2022-03-30
- Fix: OpenDocument by FilePath doesn't throw an error when file has no extension;
- Fix: OpenDocument by URL doesn't work if URL have spaces

## 2021-07-30
- Fix: Implemented a completion handler to indentify when the preview document is dismissed. [RMET-740](https://outsystemsrd.atlassian.net/browse/RMET-912)
## 2021-07-13
- Migrating package upload to newer Saucelabs API [RMET-761](https://outsystemsrd.atlassian.net/browse/RMET-761)
## 2021-07-06
- Fix: files names with white spaces were not being opened. [RMET-740](https://outsystemsrd.atlassian.net/browse/RMET-740)
## 2021-02-22
- Removed unnecessary example unit test file for Android tests.
## 2021-02-19
- Added implementation for open document in Local Resources (iOS & Android) [RMET-441](https://outsystemsrd.atlassian.net/browse/RMET-441)

## 2021-02-02
### Additions
- Added implementation for open document in iOS [RNMT-439](https://outsystemsrd.atlassian.net/browse/RMET-439)
- Added implementation for open document in Android [RNMT-440](https://outsystemsrd.atlassian.net/browse/RMET-440)

## 2021-01-26
- Added JavaScript layer for plugin [RNMT-446](https://outsystemsrd.atlassian.net/browse/RMET-446)

