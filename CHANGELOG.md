# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and the project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

## [0.1.8] - 2021-01-23
### Changed
- For sufficiently wide screens, the shape type selector and property panels will always be visible. Mainly for desktop/web.
- BoxFit selection how uses normal English, rather than directly mapping enum name.

## [0.1.7] - 2021-01-23
### Added
- Add Pyramid shape.
### Fixed
- Years in changelog were 2020, instead of 2021.

## [0.1.6] - 2021-01-23
### Added
- Add Triangle shape.
- Add Right Triangle shape.

## [0.1.5] - 2021-01-21
### Added
- Created utility class (ShapeUtils) to simplify checking if a point lies within a shape.
- Add Capsule shape (cylinder with hemispheres on either end).
- Add stadium shape (rectangle with semicircles on either end).
### Changed
- Moved viewer options (viewer type and fit) to ExpansionTile, to better visually group related items.
- Changed all Shape3d.contains overrides to use ShapeUtils methods.
- Cylinder is no longer always a perfect circle along one axis. Width and depth can be defined, as with an ellipse.
### Fixed
- Fix checkerboard pattern in SliceViewer resolving to vertical lines of the same color for certain combinations of width and height.

## [0.1.4] - 2021-01-20
### Added
- Add this CHANGELOG.md. Closes #3.
- Can view CHANGELOG.md from settings screen.
### Fixed
- Added key parameter to items in SliceViewer ListView, so they will actually be rebuilt whenever settings for shape change. Closes #2.

## [0.1.3] - 2021-01-18
### Fixed
- Fit preference now loads properly, rather than always defaulting to fitWidth.

## [0.1.2] - 2021-01-18
### Added
- Checkerboard pattern now displays under slices in SliceViewer. Closes #1.

## [0.1.1] - 2021-01-17
### Added
- Add option to view licenses in settings.
### Fixed
- Changing shape settings will now update view in SliceViewer.

## [0.1.0] - 2021-01-17
### Added
- Add ability to view a variety of shapes (circle, cube, cuboid, cylinder, ellipse, ellipsoid, rectangle, sphere, square) in either 3D or 2D (slices).
- Shapes have a number of properties that can be altered (width, depth, height, diameter, etc.).
