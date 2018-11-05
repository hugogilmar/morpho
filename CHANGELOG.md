# Changelog

All notable changes to `morpho` will be documented in this file.

Updates should follow the [Keep a CHANGELOG](http://keepachangelog.com/) principles.

### [1.1.2] - 2018-10-31

### Added

- Password validations for user sign up contract

### Changed

- Coding standars for properties and validates on entity classes

### Fixed

- Uninitialized constant error for JWT module

## [1.1.1] - 2018-10-31

### Changed

- Fixing namespace collision with class JWT

## [1.1.0] - 2018-10-31

### Changed

- Errors node as object
- Commons responses for endpoints with base default error message

## [1.0.1] - 2018-10-30

### Removed

- Name property from external entity

## [1.0.0] - 2018-10-30

### Added

- Contracts and operations for activations
- Contracts and operations for unlocks
- Contracts and operations for sign in
- Contracts and operations for sign up
- Contracts and operations for external sign in
- Contracts and operations for token refresh

### Changed

- Services instead of helper for JWT utilities
- Simple version of JWT utils helpers
- HTTP responses helpers simplified
- Spanish translations for API responses

### Removed

- JWT helper methods for encode, decode and token extract from header and payload generation
- Helper methods for sign in, sign up, password reset, activation, externals and unlock
- Sign in entities

## [0.3.4] - 2018-10-22

### Added

- External provider login endpoint
- JWT utils helper
- Register user last login activity

### Changed

- JWT logic removed from user login helper to own helper

## [0.3.3] - 2018-10-22

### Added

- Protocol configuration option

## [0.3.2] - 2018-10-19

### Changed

- Refactor grape helpers
- Refactor sign in entities

### Added

- Refresh token endpoint
- Refresh token on authentication token entity
- Refresh token field on users

### Revomed

- User password validations

## [0.3.1] - 2018-10-18

### Changed

- Error envelope for sign in and sign up responses

### Added

- Custom messages on sign in about account status
- Sign in endpoint documentation for success and failure responses
- Sign in success entity

### Removed

- Authentication token entity moved to sign in namespace

## [0.3.0] - 2018-09-27

### Added

- Spanish translations
- New cipher module
- New config in auth, for setting the minimun password

### Removed

- Removed styles and css dependencies (implement your own in the project)

## [0.2.1]
- Custom validator added for password strength check
- Engine initializer configurations from environment variables

## [0.2.0]
- No auto-mount for API routes
- API base class install from generator

## [0.1.1]
- Authentication API resources
- Authentication WEB resources
- Grape authentication concerns
- User account mailers
- Authentication, API and JWT configurations for engine
- Migrations autoload
- Engine initializer generator

## [0.1.0]
- Basic engine setup
