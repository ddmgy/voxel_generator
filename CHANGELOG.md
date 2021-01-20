# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and the project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased
### Added
- Add this CHANGELOG.md. Closes #3.
- Can view CHANGELOG.md from settings screen.
### Fixed
- Added key parameter to items in SliceViewer ListView, so they will actually be rebuilt whenever settings for shape change. Closes #2.

## [0.1.3] - 2020-01-18
### Fixed
- Fit preference now loads properly, rather than always defaulting to fitWidth.

## [0.1.2] - 2020-01-18
### Added
- Checkerboard pattern now displays under slices in SliceViewer. Closes #1.

## [0.1.1] - 2020-01-17
### Added
- Add option to view licenses in settings.
### Fixed
- Changing shape settings will now update view in SliceViewer.

## [0.1.0] - 2020-01-17
### Added
- Add ability to view a variety of shapes (circle, cube, cuboid, cylinder, ellipse, ellipsoid, rectangle, sphere, square) in either 3D or 2D (slices).
- Shapes have a number of properties that can be altered (width, depth, height, diameter, etc.).
