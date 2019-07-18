# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- None.

## [1.0.2] - 2019-07-19

### Added

- Get-ShouldContinue by default ignores preferences like the original. But if
  you want it to act more like Get-ShouldProcess then use -UsePreference.

## [1.0.1] - 2019-07-19

### Fixed

- Make it function from a <ScriptBlock> (command line) even though it shouldn't.
  This makes it easier to demo.

## [1.0.0] - 2019-07-18

### Added

- Initial release.
