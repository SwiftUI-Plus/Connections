# Connections

A set of SwiftUI dynamic property wrappers that provide a more familiar API for accessing the Contacts framework.

> A full demo is included in this repo.

## Features

- Familiar API, matches CoreData's new FetchRequest APIs
- Animation support
- View's automatically update to reflect remote changes

## Example

```swift
@FetchContactList(
    keysToFetch: [
        .type,
        .givenName, .familyName,
        .organizationName,
        .phoneNumbers
    ],
    sortOrder: .givenName
) private var contacts
```

## Installation

The code is packaged as a framework. You can install manually (by copying the files in the `Sources` directory) or using Swift Package Manager (__preferred__)

To install using Swift Package Manager, add this to the `dependencies` section of your `Package.swift` file:

`.package(url: "https://github.com/SwiftUI-Plus/Connections.git", .upToNextMinor(from: "1.0.0"))`

> Note: The package requires iOS v13+

## Other Packages

If you want easy access to this and more packages, add the following collection to your Xcode 13+ configuration:

`https://benkau.com/packages.json`

